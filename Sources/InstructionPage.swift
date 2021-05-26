//
//  InstructionPage.swift
//  TimeFlies
//
//  Created by Shaun Ku on 2021/4/9.
//

import SwiftUI

struct InstructionPage: View {
    @Binding var currentPage:Pages
    //@State var views:[AnyView] = [Instruction1()]
    var body: some View {
        VStack{
            ZStack{
                HStack{
                    Button(action: {
                    currentPage = Pages.HomePage
                    }, label: {
                        Image(systemName: "house")
                        .font(.system(size: 20*zoom, weight: .bold))
                        .foregroundColor(Color.blue)
                    })
                    .padding(.leading, 10*zoom)
                    Spacer()
                }
                Text("How to play")
                .foregroundColor(Color.yellow)
                .font(Font.custom("GillSans-Bold", size: 28*zoom))
                .multilineTextAlignment(.center)
            }
            .padding(.top, 10*zoom)
            Spacer()
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing:0*zoom){
                    ForEach(1...4, id:\.self){
                        index in
                        GeometryReader{
                            geometry in
                            InstructionDetail(page: index, currentPage: $currentPage)
                            .rotation3DEffect(Angle(degrees: (Double(geometry.frame(in: .global).minX) - Double(20*zoom)) / Double(-20*zoom)), axis: (x:0, y:10.0*zoom, z:0))
                        }
                        .frame(width: 320*zoom, height: 500*zoom)
                        .padding(.top, 10*zoom)
                        .padding(.leading, index==1 ? 40*zoom : 0)
                        .padding(.trailing, index==4 ? 30*zoom : 0)
                    }
                }
            }
            .frame(width: 410*zoom, height: 500*zoom)
            Spacer()
        }
        .frame(width: 410*zoom, height: 580*zoom)
        .background(Color.black)
    }
}

struct InstructionPage_Previews: PreviewProvider {
    static var previews: some View {
        InstructionPage(currentPage: .constant(Pages.InstructionPage))
    }
}

struct InstructionDetail: View{
    var page: Int
    @Binding var currentPage:Pages
    var body: some View {
        ZStack{
            switch(page){
                case 1:
                    InstructionPage1()
                case 2:
                    InstructionPage2()
                case 3:
                    InstructionPage3()
                case 4:
                    InstructionPage4(currentPage: $currentPage)
                default:
                    EmptyView()
            
            }
        }
    }
}

struct InstructionPage1: View{
    var body: some View {
        VStack{
            Text("Welcome to game instruction. Your goal of this game is to stop the timer exactly at target time. There are total of 4 levels. Each level has different target time, you can choose level by clicking arrows.")
            .foregroundColor(Color.white)
            .font(Font.custom("GillSans-Bold", size: 18*zoom))
            .multilineTextAlignment(.leading)
            .frame(width: 280*zoom)
            .padding(.bottom, 10*zoom)
            Image(uiImage: UIImage(named: "Instruction1.png")!)
            .resizable()
            .frame(width: 280*zoom)
            .aspectRatio(contentMode: .fit)
            .background(Rectangle().stroke(Color.white, style: StrokeStyle(lineWidth: 1*zoom)))
            .padding(.bottom, 10*zoom)
            Text("Level 1 - 4.00\nLevel 2 - 9.00\nLevel 3 - 12.34\nLevel 4 - 20.21")
            .foregroundColor(Color.white)
            .font(Font.custom("GillSans-Bold", size: 18*zoom))
            .multilineTextAlignment(.leading)
            .frame(width: 280*zoom)
        }
        .frame(width: 310*zoom, height: 480*zoom)
        .background(RoundedRectangle(cornerRadius: 30).stroke(Color.blue, style: StrokeStyle(lineWidth: 4*zoom)))
    }
}
struct InstructionPage2: View{
    var body: some View {
        VStack{
            VStack{
                HStack{
                    ResultInfo(color: Color.green, text: "Fantastic")
                    .frame(width: 170*zoom)
                    ResultInfo(color: Color.yellow, text: "So Close")
                    .frame(width: 110*zoom)
                }
                HStack{
                    ResultInfo(color: Color.orange, text: "Time exceeded")
                    .frame(width: 170*zoom)
                    ResultInfo(color: Color.red, text: "Opps")
                    .frame(width: 110*zoom)
                }
            }
            .frame(width: 280*zoom)
            Image(uiImage: UIImage(named: "Instruction2.png")!)
            .resizable()
            .frame(maxWidth: 280*zoom, maxHeight: 210*zoom)
            .aspectRatio(contentMode: .fit)
            .background(Rectangle().stroke(Color.white, style: StrokeStyle(lineWidth: 1*zoom)))
            VStack(alignment: .leading, spacing: 0*zoom){
                ZStack(alignment: .topLeading){
                    Text("Start Timer")
                    .foregroundColor(Color.blue)
                    Text("                      - The timer starts after countdown animation disappears. Disabled after the timer starts.\n")
                    .foregroundColor(Color.white)
                }
                ZStack(alignment: .topLeading){
                    Text("Stop Timer")
                    .foregroundColor(Color.red)
                    Text("                     - The timer stops and the result will show above the timer. Only able when the timer is running.")
                    .foregroundColor(Color.white)
                }
            }
            .font(Font.custom("GillSans-Bold", size: 16*zoom))
            .multilineTextAlignment(.leading)
            .frame(width: 280*zoom)
        }
        .frame(width: 310*zoom, height: 480*zoom)
        .background(RoundedRectangle(cornerRadius: 30).stroke(Color.pink, style: StrokeStyle(lineWidth: 4*zoom)))
    }
}
struct InstructionPage3: View{
    var body: some View {
        VStack{
            Image(uiImage: UIImage(named: "Instruction3.png")!)
            .resizable()
            .frame(maxWidth: 290*zoom, maxHeight: 180*zoom)
            .aspectRatio(contentMode: .fit)
            .padding(.bottom, 10*zoom)
            VStack(alignment: .leading, spacing: 0*zoom){
                ParameterName(text: "Sound Hint")
                Text("A tick tock sound will appear once per second. Remember to turn your sound on!")
                .foregroundColor(Color.white)
                .font(Font.custom("GillSans-Bold", size: 16*zoom))
                .multilineTextAlignment(.leading)
            }
            .frame(width: 280*zoom)
            VStack(alignment: .leading, spacing: 0*zoom){
                ParameterName(text: "Show Integer")
                Text("The timer on your screen will only show the integer part of time elapsed.")
                .foregroundColor(Color.white)
                .font(Font.custom("GillSans-Bold", size: 16*zoom))
                .multilineTextAlignment(.leading)
            }
            .frame(width: 280*zoom)
            VStack(alignment: .leading, spacing: 0*zoom){
                ParameterName(text: "Ink Stain")
                Text("It controls the opacity of ink stain, which covers the timer.")
                .foregroundColor(Color.white)
                .font(Font.custom("GillSans-Bold", size: 16*zoom))
                .multilineTextAlignment(.leading)
            }
            .frame(width: 280*zoom)
        }
        .frame(width: 310*zoom, height: 480*zoom)
        .background(RoundedRectangle(cornerRadius: 30).stroke(Color.yellow, style: StrokeStyle(lineWidth: 4*zoom)))
    }
}
struct InstructionPage4: View{
    @Binding var currentPage:Pages
    var body: some View {
        VStack{
            VStack(alignment: .leading, spacing: 0*zoom){
                ParameterName(text: "Curtains")
                Text("A slider that controls the width of curtains, which covers the timer.")
                .foregroundColor(Color.white)
                .font(Font.custom("GillSans-Bold", size: 16*zoom))
                .multilineTextAlignment(.leading)
            }
            .padding(.top, 20*zoom)
            .frame(width: 280*zoom)
            VStack(alignment: .leading, spacing: 0*zoom){
                ParameterName(text: "Timer Disappear")
                Text("The timer on your screen will fade out t-second(s) before target time.")
                .foregroundColor(Color.white)
                .font(Font.custom("GillSans-Bold", size: 16*zoom))
                .multilineTextAlignment(.leading)
            }
            .frame(width: 280*zoom)
            VStack(alignment: .leading, spacing: 0*zoom){
                HStack(spacing: 10*zoom){
                    Circle()
                    .fill(Color.white)
                    .frame(width: 10*zoom, height: 10*zoom)
                    Image(systemName: "clock.arrow.circlepath")
                    .font(.system(size: 16*zoom, weight: .bold))
                    .foregroundColor(Color.white)
                    Spacer()
                }
                Text("A button that can restore latest parameters.")
                .foregroundColor(Color.white)
                .font(Font.custom("GillSans-Bold", size: 16*zoom))
                .multilineTextAlignment(.leading)
            }
            .frame(width: 280*zoom)
            Spacer()
            Text("Reminder: Check your game parameters before pressing the \"Start Timer\" button!")
            .font(Font.custom("GillSans-Bold", size: 18*zoom))
            .foregroundColor(.green)
            .multilineTextAlignment(.leading)
            .frame(width:280*zoom)
            .padding(.bottom,10*zoom)
            Text("Wish You Very Good Luck :)")
            .font(Font.custom("GillSans-Bold", size: 18*zoom))
            .foregroundColor(.green)
            .multilineTextAlignment(.center)
            .frame(width:290*zoom)
            .padding(.bottom, 10*zoom)
            Button(action:{
                currentPage = Pages.GamePage
            }, label: {
                Text("Play")
                .foregroundColor(Color.green)
                .font(Font.custom("GillSans-Bold", size: 28*zoom))
                .multilineTextAlignment(.center)
                .frame(width:190*zoom, height: 60*zoom)
                .background(RoundedRectangle(cornerRadius: 20).stroke(Color.green, style: StrokeStyle(lineWidth: 2*zoom)))
            })
            .padding(.bottom, 20*zoom)
        }
        .frame(width: 310*zoom, height: 480*zoom)
        .background(RoundedRectangle(cornerRadius: 30).stroke(Color.green, style: StrokeStyle(lineWidth: 4*zoom)))
    }
}

struct ResultInfo: View{
    var color:Color
    var text:String
    var body: some View{
        HStack(spacing: 0*zoom){
            Circle()
            .fill(color)
            .frame(width: 10*zoom, height: 10*zoom)
            Text(" - \(text)")
            .font(Font.custom("GillSans-Bold", size: 16*zoom))
            .foregroundColor(color)
            .multilineTextAlignment(.center)
            Spacer()
        }
    }
}

struct ParameterName: View{
    var text:String
    var body: some View{
        HStack(spacing: 10*zoom){
            Circle()
            .fill(Color.white)
            .frame(width: 10*zoom, height: 10*zoom)
            Text("\(text)")
            .font(Font.custom("GillSans-Bold", size: 16*zoom))
            .fontWeight(.bold)
            .foregroundColor(Color.white)
            .multilineTextAlignment(.center)
            Spacer()
        }
    }
}
