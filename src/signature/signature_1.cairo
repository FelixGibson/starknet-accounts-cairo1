use serde::Serde;
use starknet::ContractAddress;
use starknet::contract_address::ContractAddressSerde;
use array::ArrayTrait;
use array::SpanTrait;

#[account_contract]
mod Signature1 {
    use array::ArrayTrait;
    use array::SpanTrait;
    use box::BoxTrait;
    use ecdsa::check_ecdsa_signature;
    use option::OptionTrait;
    use starknet::ContractAddress;
    use starknet::ContractAddressZeroable;
    use zeroable::Zeroable;

    struct Storage {
        public_key: felt252
    }

    #[constructor]
    fn constructor(public_key_: felt252) {
        public_key::write(public_key_);
    }

    fn validate_transaction() -> felt252 {
        let tx_info = starknet::get_tx_info().unbox();
        let signature = tx_info.signature;
        assert(signature.len() == 2_u32, 'INVALID_SIGNATURE_LENGTH');
        assert(
            check_ecdsa_signature(
                message_hash: tx_info.transaction_hash,
                public_key: public_key::read(),
                signature_r: *signature.at(0_u32),
                signature_s: *signature.at(1_u32),
            ),
            'INVALID_SIGNATURE',
        );

        starknet::VALIDATED
    }


    #[external]
    fn __validate_deploy__(
        class_hash: felt252, contract_address_salt: felt252, public_key_: felt252
    ) -> felt252 {
        validate_transaction()
    }

    #[external]
    fn __validate_declare__(class_hash: felt252) -> felt252 {
        validate_transaction()
    }

    #[external]
    fn __validate__(
        contract_address: ContractAddress, entry_point_selector: felt252, calldata: Array::<felt252>
    ) -> felt252 {
        validate_transaction()
    }

    #[external]
    #[raw_output]
    fn __execute__(
        contract_address: ContractAddress, entry_point_selector: felt252, calldata: Array::<felt252>
    ) -> Span::<felt252> {
        // Validate caller.
        assert(starknet::get_caller_address().is_zero(), 'INVALID_CALLER');

        // Check the tx version here, since version 0 transaction skip the __validate__ function.
        let tx_info = starknet::get_tx_info().unbox();
        assert(tx_info.version != 0, 'INVALID_TX_VERSION');

        let hash = pedersen(*calldata.at(0_usize), *calldata.at(1_usize));
        let mut vec = ArrayTrait::new();
        vec.append(hash);
        vec.append(*calldata.at(2_usize));


        starknet::call_contract_syscall(
            contract_address, entry_point_selector, vec.span()
        ).unwrap_syscall()
    }
}
