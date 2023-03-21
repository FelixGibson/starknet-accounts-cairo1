#[account_contract]
mod HelloAccount {
    use starknet::ContractAddress;
    use core::felt252;
    use array::ArrayTrait;
    use array::SpanTrait;

    struct Storage {
    }

    #[external]
    fn __validate_deploy__(
        class_hash: felt252, contract_address_salt: felt252, public_key_: felt252
    ) -> felt252 {
        starknet::VALIDATED
    }

    #[external]
    fn __validate_declare__(class_hash: felt252) -> felt252 {
        starknet::VALIDATED
    }

    #[external]
    fn __validate__(
        contract_address: ContractAddress, entry_point_selector: felt252, calldata: Array::<felt252>
    ) -> felt252 {
        starknet::VALIDATED
    }


    #[external]
    #[raw_output]
    fn __execute__(
        contract_address: ContractAddress, entry_point_selector: felt252, calldata: Array::<felt252>
    ) -> Span::<felt252> {
        starknet::call_contract_syscall(
            contract_address, entry_point_selector, calldata.span()
        ).unwrap_syscall()
    }
}
