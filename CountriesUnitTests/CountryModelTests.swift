//
//  CountryModelTests.swift
//  CountriesUnitTests
//
//  Created by Alessandro Di Maio on 26/09/22.
//

import XCTest
@testable import Countries

class CountryModelTests: XCTestCase {
    
    func testCountryInit() {
        let newCountry = Country(
            name: .init(common: "Italy", official: "Italian Republic"),
            continent: .europe,
            capital: .init(
                name: "Rome",
                location: .init(latitude: 41.9, longitude: 12.48)
            ),
            location: .init(latitude: 42.83333333, longitude: 12.83333333),
            borders: ["AUT", "FRA", "SMR", "SVN", "CHE", "VAT"],
            tlds: [".it"],
            code: "ITA",
            currencies: [.init(name: "Euro", symbol: "€", ISO4217: "EUR")],
            languages: ["Italian"],
            area: 301336.0,
            population: 59554023,
            flags: .init(
                png: URL(string: "https://flagcdn.com/w320/it.png")!,
                svg: URL(string: "https://flagcdn.com/it.svg")!
            )
        )
        
        XCTAssertEqual(newCountry, Country.italy)
    }
    
    func testCountryInitFromDecoder() throws {
        
        let json = """
        {
            "name": {
                "common": "Italy",
                "official": "Italian Republic",
                "nativeName": {
                    "ita": {
                        "official": "Repubblica italiana",
                        "common": "Italia"
                    }
                }
            },
            "tld": [
                ".it"
            ],
            "cca2": "IT",
            "ccn3": "380",
            "cca3": "ITA",
            "cioc": "ITA",
            "independent": true,
            "status": "officially-assigned",
            "unMember": true,
            "currencies": {
                "EUR": {
                    "name": "Euro",
                    "symbol": "€"
                }
            },
            "idd": {
                "root": "+3",
                "suffixes": [
                    "9"
                ]
            },
            "capital": [
                "Rome"
            ],
            "altSpellings": [
                "IT",
                "Italian Republic",
                "Repubblica italiana"
            ],
            "region": "Europe",
            "subregion": "Southern Europe",
            "languages": {
                "ita": "Italian"
            },
            "translations": {
                "ara": {
                    "official": "الجمهورية الإيطالية",
                    "common": "إيطاليا"
                },
                "bre": {
                    "official": "Republik Italia",
                    "common": "Italia"
                },
                "ces": {
                    "official": "Italská republika",
                    "common": "Itálie"
                },
                "cym": {
                    "official": "Italian Republic",
                    "common": "Italy"
                },
                "deu": {
                    "official": "Italienische Republik",
                    "common": "Italien"
                },
                "est": {
                    "official": "Itaalia Vabariik",
                    "common": "Itaalia"
                },
                "fin": {
                    "official": "Italian tasavalta",
                    "common": "Italia"
                },
                "fra": {
                    "official": "République italienne",
                    "common": "Italie"
                },
                "hrv": {
                    "official": "talijanska Republika",
                    "common": "Italija"
                },
                "hun": {
                    "official": "Olasz Köztársaság",
                    "common": "Olaszország"
                },
                "ita": {
                    "official": "Repubblica italiana",
                    "common": "Italia"
                },
                "jpn": {
                    "official": "イタリア共和国",
                    "common": "イタリア"
                },
                "kor": {
                    "official": "이탈리아 공화국",
                    "common": "이탈리아"
                },
                "nld": {
                    "official": "Italiaanse Republiek",
                    "common": "Italië"
                },
                "per": {
                    "official": "جمهوری ایتالیا",
                    "common": "ایتالیا"
                },
                "pol": {
                    "official": "Republika Włoska",
                    "common": "Włochy"
                },
                "por": {
                    "official": "República Italiana",
                    "common": "Itália"
                },
                "rus": {
                    "official": "итальянская Республика",
                    "common": "Италия"
                },
                "slk": {
                    "official": "Talianska republika",
                    "common": "Taliansko"
                },
                "spa": {
                    "official": "República Italiana",
                    "common": "Italia"
                },
                "swe": {
                    "official": "Republiken Italien",
                    "common": "Italien"
                },
                "tur": {
                    "official": "İtalyan Cumhuriyeti",
                    "common": "İtalya"
                },
                "urd": {
                    "official": "جمہوریہ اطالیہ",
                    "common": "اطالیہ"
                },
                "zho": {
                    "official": "意大利共和国",
                    "common": "意大利"
                }
            },
            "latlng": [
                42.83333333,
                12.83333333
            ],
            "landlocked": false,
            "borders": [
                "AUT",
                "FRA",
                "SMR",
                "SVN",
                "CHE",
                "VAT"
            ],
            "area": 301336.0,
            "demonyms": {
                "eng": {
                    "f": "Italian",
                    "m": "Italian"
                },
                "fra": {
                    "f": "Italienne",
                    "m": "Italien"
                }
            },
            "flag": "🇮🇹",
            "maps": {
                "googleMaps": "https://goo.gl/maps/8M1K27TDj7StTRTq8",
                "openStreetMaps": "https://www.openstreetmap.org/relation/365331"
            },
            "population": 59554023,
            "gini": {
                "2017": 35.9
            },
            "fifa": "ITA",
            "car": {
                "signs": [
                    "I"
                ],
                "side": "right"
            },
            "timezones": [
                "UTC+01:00"
            ],
            "continents": [
                "Europe"
            ],
            "flags": {
                "png": "https://flagcdn.com/w320/it.png",
                "svg": "https://flagcdn.com/it.svg"
            },
            "coatOfArms": {
                "png": "https://mainfacts.com/media/images/coats_of_arms/it.png",
                "svg": "https://mainfacts.com/media/images/coats_of_arms/it.svg"
            },
            "startOfWeek": "monday",
            "capitalInfo": {
                "latlng": [
                    41.9,
                    12.48
                ]
            }
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        decoder.assumesTopLevelDictionary = true
        
        let country = try decoder.decode(Country.self, from: json)
        
        XCTAssertEqual(Country.italy, country)
    }
    
    func testContryDecodingErrorMissingKey() {
        //For this purpose we remove purposely a fundamental non optional key like name.
        let json = """
        {
            "tld": [
                ".it"
            ],
            "cca2": "IT",
            "ccn3": "380",
            "cca3": "ITA",
            "cioc": "ITA",
            "independent": true,
            "status": "officially-assigned",
            "unMember": true,
            "currencies": {
                "EUR": {
                    "name": "Euro",
                    "symbol": "€"
                }
            },
            "idd": {
                "root": "+3",
                "suffixes": [
                    "9"
                ]
            },
            "capital": [
                "Rome"
            ],
            "altSpellings": [
                "IT",
                "Italian Republic",
                "Repubblica italiana"
            ],
            "region": "Europe",
            "subregion": "Southern Europe",
            "languages": {
                "ita": "Italian"
            },
            "translations": {
                "ara": {
                    "official": "الجمهورية الإيطالية",
                    "common": "إيطاليا"
                },
                "bre": {
                    "official": "Republik Italia",
                    "common": "Italia"
                },
                "ces": {
                    "official": "Italská republika",
                    "common": "Itálie"
                },
                "cym": {
                    "official": "Italian Republic",
                    "common": "Italy"
                },
                "deu": {
                    "official": "Italienische Republik",
                    "common": "Italien"
                },
                "est": {
                    "official": "Itaalia Vabariik",
                    "common": "Itaalia"
                },
                "fin": {
                    "official": "Italian tasavalta",
                    "common": "Italia"
                },
                "fra": {
                    "official": "République italienne",
                    "common": "Italie"
                },
                "hrv": {
                    "official": "talijanska Republika",
                    "common": "Italija"
                },
                "hun": {
                    "official": "Olasz Köztársaság",
                    "common": "Olaszország"
                },
                "ita": {
                    "official": "Repubblica italiana",
                    "common": "Italia"
                },
                "jpn": {
                    "official": "イタリア共和国",
                    "common": "イタリア"
                },
                "kor": {
                    "official": "이탈리아 공화국",
                    "common": "이탈리아"
                },
                "nld": {
                    "official": "Italiaanse Republiek",
                    "common": "Italië"
                },
                "per": {
                    "official": "جمهوری ایتالیا",
                    "common": "ایتالیا"
                },
                "pol": {
                    "official": "Republika Włoska",
                    "common": "Włochy"
                },
                "por": {
                    "official": "República Italiana",
                    "common": "Itália"
                },
                "rus": {
                    "official": "итальянская Республика",
                    "common": "Италия"
                },
                "slk": {
                    "official": "Talianska republika",
                    "common": "Taliansko"
                },
                "spa": {
                    "official": "República Italiana",
                    "common": "Italia"
                },
                "swe": {
                    "official": "Republiken Italien",
                    "common": "Italien"
                },
                "tur": {
                    "official": "İtalyan Cumhuriyeti",
                    "common": "İtalya"
                },
                "urd": {
                    "official": "جمہوریہ اطالیہ",
                    "common": "اطالیہ"
                },
                "zho": {
                    "official": "意大利共和国",
                    "common": "意大利"
                }
            },
            "latlng": [
                42.83333333,
                12.83333333
            ],
            "landlocked": false,
            "borders": [
                "AUT",
                "FRA",
                "SMR",
                "SVN",
                "CHE",
                "VAT"
            ],
            "area": 301336.0,
            "demonyms": {
                "eng": {
                    "f": "Italian",
                    "m": "Italian"
                },
                "fra": {
                    "f": "Italienne",
                    "m": "Italien"
                }
            },
            "flag": "🇮🇹",
            "maps": {
                "googleMaps": "https://goo.gl/maps/8M1K27TDj7StTRTq8",
                "openStreetMaps": "https://www.openstreetmap.org/relation/365331"
            },
            "population": 59554023,
            "gini": {
                "2017": 35.9
            },
            "fifa": "ITA",
            "car": {
                "signs": [
                    "I"
                ],
                "side": "right"
            },
            "timezones": [
                "UTC+01:00"
            ],
            "continents": [
                "Europe"
            ],
            "flags": {
                "png": "https://flagcdn.com/w320/it.png",
                "svg": "https://flagcdn.com/it.svg"
            },
            "coatOfArms": {
                "png": "https://mainfacts.com/media/images/coats_of_arms/it.png",
                "svg": "https://mainfacts.com/media/images/coats_of_arms/it.svg"
            },
            "startOfWeek": "monday",
            "capitalInfo": {
                "latlng": [
                    41.9,
                    12.48
                ]
            }
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        decoder.assumesTopLevelDictionary = true
        
        XCTAssertThrowsError(try decoder.decode(Country.self, from: json))
    }
}
