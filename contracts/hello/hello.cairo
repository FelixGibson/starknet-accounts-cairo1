#[account_contract]
mod HelloAccount {
    use array::SpanTrait;
    use ecdsa::check_ecdsa_signature;
    use starknet::ContractAddress;

    struct Storage {
    }

    #[external]
    fn __validate_deploy__(
        class_hash: felt, contract_address_salt: felt, public_key_: felt
    ) -> felt {
        // Note that the storage var is not set at this point, so we need to take the public
        // key from the arguments.
    }

    #[external]
    fn __validate_declare__(class_hash: felt) -> felt {
    }

    #[external]
    fn __validate__(
        contract_address: ContractAddress, entry_point_selector: felt, calldata: Array::<felt>
    ) -> felt {
    }


    // TODO(ilya): Support raw_output attribute.
    #[external]
    fn __execute__(
        contract_address: ContractAddress, entry_point_selector: felt, calldata: Array::<felt>
    ) -> Array::<felt> {
        starknet::call_contract_syscall(
            contract_address, entry_point_selector, calldata
        ).unwrap_syscall()
    }
}
