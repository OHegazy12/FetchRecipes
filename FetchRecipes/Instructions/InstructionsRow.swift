//
//  InstructionsRow.swift
//  FetchRecipes
//
//  Created by Omar Hegazy on 4/7/23.
//

import SwiftUI

struct InstructionsRow: View
{
    let instruction: String
    var body: some View
    {
        HStack
        {
            Text(instruction)
                .font(.system(size: 18, weight: .regular,design: .rounded))
                .foregroundColor(.white)
                .minimumScaleFactor(0.005)
                .multilineTextAlignment(.leading)
        }
    }
}

struct InstructionsRow_Previews: PreviewProvider
{
    static var previews: some View
    {
        InstructionsRow(instruction: "Put the cake in the oven")
    }
}

