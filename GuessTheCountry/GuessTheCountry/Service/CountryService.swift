//
//  CountryService.swift
//  GuessTheCountry
//
//  Created by Yannick JACQUELINE on 27/10/2023.
//

import Foundation

enum ServiceError: Error {
    case invalidUrl
}

protocol CountryService {
    func getCountries() async throws -> [Country]
}

struct RemoteCountryService: CountryService {
    
    let session: URLSession
    
    func getCountries() async throws -> [Country] {
        let urlString = Constants.Endpoints.countryService
        guard let url = URL(string: urlString) else {
            throw ServiceError.invalidUrl
        }
        let result = try await session.data(from: url)
        
        let returnValue = try JSONDecoder().decode([Country].self, from: result.0)
        return returnValue
    }
}
