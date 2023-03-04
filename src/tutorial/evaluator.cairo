#[contract]
mod Evaluator {
    use zeroable::Zeroable;
    use starknet::get_caller_address;
    use starknet::contract_address_const;
    use starknet::ContractAddressZeroable;

    struct Storage {
        name: felt,
        symbol: felt,
        decimals: u8,
        total_supply: u256,
        balances: LegacyMap::<ContractAddress, u256>,
        allowances: LegacyMap::<(ContractAddress, ContractAddress), u256>,
        teachers_and_exercises_accounts: LegacyMap::<ContractAddress, u256>,
    }

    
    #[event]
    fn Payday(address: ContractAddress, contract: ContractAddress) {}




}