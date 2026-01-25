extension String {
    func capitalizeFirstLetter() -> String {
        guard let first = self.first else { return self }
        return first.uppercased() + self.dropFirst().lowercased()
    }
}
