public protocol ViewModelType {
    associatedtype Inputs
    associatedtype Outputs
    
    mutating func transform(input: Inputs) -> Outputs
}

