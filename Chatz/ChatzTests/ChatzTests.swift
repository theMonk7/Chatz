//
//  ChatzTests.swift
//  ChatzTests
//
//  Created by Utkarsh Raj on 06/11/24.
//

import XCTest
@testable import Chatz


final class ChatMessageTest: XCTestCase {
    var sut: ChatMessage!
    
    override func setUp() {
        sut = ChatMessage(text: "Apple", uid: "1", displayName: "Mango")
    }
    
    override func tearDown() {
        
    }
    
    func test_chat_message_model_to_dict() {
        let dict = sut.toDictionary()
        XCTAssertEqual(dict["text"] as! String, sut.text)
    }



}
