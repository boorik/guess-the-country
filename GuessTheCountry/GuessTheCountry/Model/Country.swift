//
//  Country.swift
//  GuessTheCountry
//
//  Created by Yannick JACQUELINE on 27/10/2023.
//

import Foundation

// MARK: - WelcomeElement
struct Country: Decodable {
    let name: Name
    let tld: [String]?
    let independent: Bool?
    let status: Status
    let unMember: Bool
    let currencies: Currencies?
    let idd: Idd
    let capital: [String]?
    let altSpellings: [String]
    let region: Region
    let subregion: String?
    let languages: [String: String]?
    let translations: [String: Translation]
    let latlng: [Double]
    let landlocked: Bool
    let borders: [String]?
    let area: Double
    let demonyms: Demonyms?
    let flag: String
    let maps: Maps
    let population: Int
    let gini: [String: Double]?
    let fifa: String?
    let car: Car
    let timezones: [String]
    let continents: [Continent]
    let flags: Flags
    let coatOfArms: CoatOfArms
    let startOfWeek: StartOfWeek
    let capitalInfo: CapitalInfo
    let postalCode: PostalCode?
}

// MARK: - CapitalInfo
struct CapitalInfo: Codable {
    let latlng: [Double]?
}

// MARK: - Car
struct Car: Codable {
    let signs: [String]?
    let side: Side
}

enum Side: String, Codable {
    case sideLeft = "left"
    case sideRight = "right"
}

// MARK: - CoatOfArms
struct CoatOfArms: Codable {
    let png: String?
    let svg: String?
}

enum Continent: String, Codable {
    case africa = "Africa"
    case antarctica = "Antarctica"
    case asia = "Asia"
    case europe = "Europe"
    case northAmerica = "North America"
    case oceania = "Oceania"
    case southAmerica = "South America"
}

// MARK: - Currencies
struct Currencies: Codable {
    let uzs, eur, sll, aud: Aed?
    let mru, ils, mdl, fjd: Aed?
    let rsd, xaf, bsd, usd: Aed?
    let czk, egp, mmk, uyu: Aed?
    let gbp, shp, cop, kgs: Aed?
    let mwk, huf, cve, zar: Aed?
    let dkk, xpf, srd, xof: Aed?
    let top, gip, cad, kpw: Aed?
    let tvd, pab, rwf, jmd: Aed?
    let bhd, ang, pkr, kzt: Aed?
    let lak, ttd, nzd, lrd: Aed?
    let xcd, pgk, clp, sar: Aed?
    let nok, gmd, php, imp: Aed?
    let hnl, lbp, mad, fok: Aed?
    let ars, nad, vnd, mzn: Aed?
    let amd, kes, btn, inr: Aed?
    let aed, ckd, etb, sgd: Aed?
    let pen, jod, wst, ssp: Aed?
    let szl, tjs, zmw, bif: Aed?
    let jpy, ugx, mnt, ngn: Aed?
    let gtq, jep, crc, yer: Aed?
    let mga, dzd, lkr, bmd: Aed?
    let mkd, npr, chf, cdf: Aed?
    let bzd, qar, idr, lsl: Aed?
    let pln, ggp, twd, hkd: Aed?
    let tmt, rub, azn, khr: Aed?
    let bwp, pyg, bob, mvr: Aed?
    let isk, bnd, afn, ghs: Aed?
    let kwd, bdt, gyd, kid: Aed?
    let bbd, all, mop, scr: Aed?
    let krw, tnd, irr, currenciesTRY: Aed?
    let tzs, uah, mur, sos: Aed?
    let gnf, sbd, nio, dop: Aed?
    let iqd, ves, zwl, sek: Aed?
    let thb: Aed?
    let bam: BAM?
    let fkp, djf, htg, kmf: Aed?
    let byn, kyd, cny: Aed?
    let sdg: BAM?
    let omr, mxn, cuc, cup: Aed?
    let ern, bgn, ron, vuv: Aed?
    let syp, stn, aoa, awg: Aed?
    let myr, gel, lyd, brl: Aed?

    enum CodingKeys: String, CodingKey {
        case uzs = "UZS"
        case eur = "EUR"
        case sll = "SLL"
        case aud = "AUD"
        case mru = "MRU"
        case ils = "ILS"
        case mdl = "MDL"
        case fjd = "FJD"
        case rsd = "RSD"
        case xaf = "XAF"
        case bsd = "BSD"
        case usd = "USD"
        case czk = "CZK"
        case egp = "EGP"
        case mmk = "MMK"
        case uyu = "UYU"
        case gbp = "GBP"
        case shp = "SHP"
        case cop = "COP"
        case kgs = "KGS"
        case mwk = "MWK"
        case huf = "HUF"
        case cve = "CVE"
        case zar = "ZAR"
        case dkk = "DKK"
        case xpf = "XPF"
        case srd = "SRD"
        case xof = "XOF"
        case top = "TOP"
        case gip = "GIP"
        case cad = "CAD"
        case kpw = "KPW"
        case tvd = "TVD"
        case pab = "PAB"
        case rwf = "RWF"
        case jmd = "JMD"
        case bhd = "BHD"
        case ang = "ANG"
        case pkr = "PKR"
        case kzt = "KZT"
        case lak = "LAK"
        case ttd = "TTD"
        case nzd = "NZD"
        case lrd = "LRD"
        case xcd = "XCD"
        case pgk = "PGK"
        case clp = "CLP"
        case sar = "SAR"
        case nok = "NOK"
        case gmd = "GMD"
        case php = "PHP"
        case imp = "IMP"
        case hnl = "HNL"
        case lbp = "LBP"
        case mad = "MAD"
        case fok = "FOK"
        case ars = "ARS"
        case nad = "NAD"
        case vnd = "VND"
        case mzn = "MZN"
        case amd = "AMD"
        case kes = "KES"
        case btn = "BTN"
        case inr = "INR"
        case aed = "AED"
        case ckd = "CKD"
        case etb = "ETB"
        case sgd = "SGD"
        case pen = "PEN"
        case jod = "JOD"
        case wst = "WST"
        case ssp = "SSP"
        case szl = "SZL"
        case tjs = "TJS"
        case zmw = "ZMW"
        case bif = "BIF"
        case jpy = "JPY"
        case ugx = "UGX"
        case mnt = "MNT"
        case ngn = "NGN"
        case gtq = "GTQ"
        case jep = "JEP"
        case crc = "CRC"
        case yer = "YER"
        case mga = "MGA"
        case dzd = "DZD"
        case lkr = "LKR"
        case bmd = "BMD"
        case mkd = "MKD"
        case npr = "NPR"
        case chf = "CHF"
        case cdf = "CDF"
        case bzd = "BZD"
        case qar = "QAR"
        case idr = "IDR"
        case lsl = "LSL"
        case pln = "PLN"
        case ggp = "GGP"
        case twd = "TWD"
        case hkd = "HKD"
        case tmt = "TMT"
        case rub = "RUB"
        case azn = "AZN"
        case khr = "KHR"
        case bwp = "BWP"
        case pyg = "PYG"
        case bob = "BOB"
        case mvr = "MVR"
        case isk = "ISK"
        case bnd = "BND"
        case afn = "AFN"
        case ghs = "GHS"
        case kwd = "KWD"
        case bdt = "BDT"
        case gyd = "GYD"
        case kid = "KID"
        case bbd = "BBD"
        case all = "ALL"
        case mop = "MOP"
        case scr = "SCR"
        case krw = "KRW"
        case tnd = "TND"
        case irr = "IRR"
        case currenciesTRY = "TRY"
        case tzs = "TZS"
        case uah = "UAH"
        case mur = "MUR"
        case sos = "SOS"
        case gnf = "GNF"
        case sbd = "SBD"
        case nio = "NIO"
        case dop = "DOP"
        case iqd = "IQD"
        case ves = "VES"
        case zwl = "ZWL"
        case sek = "SEK"
        case thb = "THB"
        case bam = "BAM"
        case fkp = "FKP"
        case djf = "DJF"
        case htg = "HTG"
        case kmf = "KMF"
        case byn = "BYN"
        case kyd = "KYD"
        case cny = "CNY"
        case sdg = "SDG"
        case omr = "OMR"
        case mxn = "MXN"
        case cuc = "CUC"
        case cup = "CUP"
        case ern = "ERN"
        case bgn = "BGN"
        case ron = "RON"
        case vuv = "VUV"
        case syp = "SYP"
        case stn = "STN"
        case aoa = "AOA"
        case awg = "AWG"
        case myr = "MYR"
        case gel = "GEL"
        case lyd = "LYD"
        case brl = "BRL"
    }
}

// MARK: - Aed
struct Aed: Codable {
    let name, symbol: String
}

// MARK: - BAM
struct BAM: Codable {
    let name: String
}

// MARK: - Demonyms
struct Demonyms: Decodable {
    let eng: Eng
    let fra: Eng?
}

// MARK: - Eng
struct Eng: Decodable {
    let female, male: String

    enum CodingKeys: String, CodingKey {
        case female = "f"
        case male = "m"
    }
}

// MARK: - Flags
struct Flags: Codable {
    let png: String
    let svg: String
    let alt: String?
}

// MARK: - Idd
struct Idd: Codable {
    let root: String?
    let suffixes: [String]?
}

// MARK: - Maps
struct Maps: Codable {
    let googleMaps, openStreetMaps: String
}

// MARK: - Name
struct Name: Codable {
    let common, official: String
    let nativeName: [String: Translation]?
}

// MARK: - Translation
struct Translation: Codable {
    let official, common: String
}

// MARK: - PostalCode
struct PostalCode: Codable {
    let format: String
    let regex: String?
}

enum Region: String, Codable {
    case africa = "Africa"
    case americas = "Americas"
    case antarctic = "Antarctic"
    case asia = "Asia"
    case europe = "Europe"
    case oceania = "Oceania"
}

enum StartOfWeek: String, Codable {
    case monday = "monday"
    case saturday = "saturday"
    case sunday = "sunday"
}

enum Status: String, Codable {
    case officiallyAssigned = "officially-assigned"
    case userAssigned = "user-assigned"
}

typealias Welcome = [Country]
