//
//  CodicEnglishDictionary.swift
//  Codic
//
//  Created by to4iki on 5/5/15.
//  Copyright (c) 2015 to4iki. All rights reserved.
//

extension Codic {
    
    /**
    *  CED
    */
    public struct CodicEnglishDictionary {
        
        /**
        *  Transcription
        */
        public struct Transcription {
            
            /**
            Notation
            */
            public enum Notation: String {
                case IPA = "IPA"
                case Katakana = "katakana"
            }
            
            /// Text
            let text: String
            /// Labels
            let labels: [String]
            /// Note
            let note: String?
            /// Notation
            let notation: Notation
            
            /**
            Initializer
            
            :param: dictionary json object
            
            :returns: self
            */
            init?(dictionary: NSDictionary) {
                if
                    let text = dictionary["text"] as? String,
                    let labels = dictionary["labels"] as? [String],
                    let rawNotation = dictionary["notation"] as? String,
                    let notation = Notation(rawValue: rawNotation)
                {
                    self.text = text
                    self.labels = labels
                    self.note = dictionary["note"] as? String
                    self.notation = notation
                } else {
                    return nil
                }
            }
        }
        
        /**
        *  Translation
        */
        public struct Translation {
            
            /// Text
            let text: String
            /// Labels
            let labels: [String]
            /// Note
            let note: String?
            /// Etymology
            let etymology: Int
            /// Pos
            let pos: String
            
            /**
            Initializer
            
            :param: dictionary json object
            
            :returns: self
            */
            init?(dictionary: NSDictionary) {
                if
                    let text = dictionary["text"] as? String,
                    let labels = dictionary["labels"] as? [String],
                    let etymology = dictionary["etymology"] as? Int,
                    let pos = dictionary["pos"] as? String
                {
                    self.text = text
                    self.labels = labels
                    self.note = dictionary["note"] as? String
                    self.etymology = etymology
                    self.pos = pos
                } else {
                    return nil
                }
            }
        }
        
        /**
        *  CED Head Word
        */
        public struct HeadWord {
            
            /// CED id
            let id: Int
            /// CED title
            let title: String
            /// CED digest
            let digest: String
            
            /**
            Initializer
            
            :param: dictionary json object
            
            :returns: self
            */
            init?(dictionary: NSDictionary) {
                if
                    let id = dictionary["id"] as? Int,
                    let title = dictionary["title"] as? String,
                    let digest = dictionary["digest"] as? String
                {
                    self.id = id
                    self.title = title
                    self.digest = digest
                } else {
                    return nil
                }
            }
        }
        
        /**
        *  CED Entry
        */
        public struct Entry {
            
            /// CED id
            let id: Int
            /// CED title
            let title: String
            /// Transciptions
            let transcriptions: [Transcription]
            /// Translations
            let translations: [Translation]
            
            /**
            Initializer
            
            :param: dictionary json object
            
            :returns: self
            */
            init?(dictionary: NSDictionary) {
                if
                    let id = dictionary["id"] as? Int,
                    let title = dictionary["title"] as? String,
                    let rawTranscriptions = dictionary["transcriptions"] as? [NSDictionary],
                    let rawTranslations = dictionary["translations"] as? [NSDictionary]
                {
                    self.id = id
                    self.title = title
                    
                    var transcriptions = [Transcription]()
                    for dictionary in rawTranscriptions {
                        if let transcription = Transcription(dictionary: dictionary) {
                            transcriptions.append(transcription)
                        }
                    }
                    self.transcriptions = transcriptions
                    
                    var translations = [Translation]()
                    for dictionary in rawTranslations {
                        if let translation = Translation(dictionary: dictionary) {
                            translations.append(translation)
                        }
                    }
                    self.translations = translations
                    
                } else {
                    return nil
                }
            }
        }
    }
}

/// MARK: - Printable
extension Codic.CodicEnglishDictionary.Transcription: Printable {
    public var description: String {
        return "CodicEnglishDictionary.Transcription(text: \(text), labels: \(labels.description), note: \(note), notation: \(notation.rawValue))"
    }
}

extension Codic.CodicEnglishDictionary.Translation: Printable {
    public var description: String {
        return "CodicEnglishDictionary.Translation(text: \(text), labels: \(labels.description), note: \(note), etymology: \(etymology), pos: \(pos))"
    }
}

extension Codic.CodicEnglishDictionary.HeadWord: Printable {
    public var description: String {
        return "CodicEnglishDictionary.HeadWord(id: \(id), title: \(title), digest: \(digest))"
    }
}

extension Codic.CodicEnglishDictionary.Entry: Printable {
    public var description: String {
        return "CodicEnglishDictionary.Entry(id: \(id), title: \(title), transcriptions: \(transcriptions.description), translations: \(translations.description))"
    }
}
