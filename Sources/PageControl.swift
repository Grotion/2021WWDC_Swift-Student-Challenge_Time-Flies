//
//  PageControl.swift
//  TimeFlies
//
//  Created by Shaun Ku on 2021/4/9.
//

import SwiftUI
enum Pages{
    case HomePage, GamePage, InstructionPage
}
//let zoom:CGFloat = 2.28
let zoom:CGFloat = 1
struct PageControl: View {
    @State var currentPage = Pages.HomePage
    var body: some View {
        ZStack
        {
            switch currentPage
            {
                case Pages.HomePage: HomePage(currentPage: $currentPage)
                case Pages.InstructionPage: InstructionPage(currentPage: $currentPage)
                case Pages.GamePage: GamePage(currentPage: $currentPage)
            }
        }
    }
}

struct PageControl_Previews: PreviewProvider {
    static var previews: some View {
        PageControl()
    }
}
