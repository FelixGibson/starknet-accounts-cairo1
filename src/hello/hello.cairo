#[account_contract]
mod HelloAccount {
    use starknet::ContractAddress;
    use core::felt;

    struct Storage {
    }

    #[external]
    fn __validate_deploy__(
        class_hash: felt, contract_address_salt: felt, public_key_: felt
    ) -> felt {
        starknet::VALIDATED
    }

    #[external]
    fn __validate_declare__(class_hash: felt) -> felt {
        starknet::VALIDATED
    }

    #[external]
    fn __validate__(
        contract_address: ContractAddress, entry_point_selector: felt, calldata: Array::<felt>
    ) -> felt {
        starknet::VALIDATED
    }


    #[external]
    #[raw_output]
    fn __execute__(
        contract_address: ContractAddress, entry_point_selector: felt, calldata: Array::<felt>
    ) -> Array::<felt> {
        starknet::call_contract_syscall(
            contract_address, entry_point_selector, calldata
        ).unwrap_syscall()
    }
}
