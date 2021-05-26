//
//  HomePage.swift
//  TimeFlies
//
//  Created by Shaun Ku on 2021/4/9.
//

import SwiftUI
import AVFoundation

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}

struct HomePage: View {
    @Binding var currentPage:Pages
    @State private var timeSpeed:Double = 3.00
    @State private var viewID = false
    var soundTest: AVPlayer{AVPlayer.sharedTickTockPlayer}
    func viewIDToggle(_ value: Double){
        viewID.toggle()
    }
    var body: some View {
        VStack{
            Spacer()
            Text("Time Flies⏱")
            .foregroundColor(.white)
            .font(Font.custom("GillSans-Bold", size: 50*zoom))
            .multilineTextAlignment(.center)
            Spacer()
            VStack(alignment: .leading, spacing: 10*zoom){
                VStack(spacing: 0*zoom){
                    Text("“Time gives legitimacy to its existence. Time is the only true unit of measure. It gives proof to the existence of matter. Without time, we don't exist.”")
                    HStack{
                        Spacer()
                        Text("- Lucy(2014)")
                    }
                }
                .font(Font.custom("Baskerville-SemiBoldItalic", size: 16*zoom))
                Text("If we control time, we control everything. Below is an example about time measuring, assuming there is a car running on an empty road, when you speed up time, the car seems still. If you speed up time to limit, the car disappears. Isn’t time amazing?")
                .font(Font.custom("GillSans-Bold", size: 16*zoom))
            }
            .foregroundColor(.white)
            
            .multilineTextAlignment(.leading)
            //.background(Rectangle().stroke(Color.white))
            .frame(width: 380*zoom)
            Spacer()
            CarRunning(timeSpeed: timeSpeed)
            .id(viewID ? 1 : 0)
            Slider(value: $timeSpeed.onChange(viewIDToggle), in: 0.0...3.0, step:0.01,minimumValueLabel: Image(systemName: "hare").font(.system(size: 20*zoom, weight: .bold)).foregroundColor(Color.white), maximumValueLabel: Image(systemName: "tortoise").font(.system(size: 20*zoom, weight: .bold)).foregroundColor(Color.white)){}
            .frame(width: 350*zoom)
            Spacer()
            VStack(spacing: 20*zoom){
                Button(action:{
                    soundTest.pause()
                    currentPage = Pages.InstructionPage
                }, label: {
                    Text("How to play")
                    .foregroundColor(Color.yellow)
                    .font(Font.custom("GillSans-Bold", size: 28*zoom))
                    .multilineTextAlignment(.center)
                    .frame(width:200*zoom, height: 50*zoom)
                    .background(RoundedRectangle(cornerRadius: 20).stroke(Color.yellow, style: StrokeStyle(lineWidth: 2*zoom)))
                })
                Button(action:{
                    soundTest.pause()
                    currentPage = Pages.GamePage
                }, label: {
                    Text("Play")
                    .foregroundColor(Color.green)
                    .font(Font.custom("GillSans-Bold", size: 28*zoom))
                    .multilineTextAlignment(.center)
                    .frame(width:200*zoom, height: 50*zoom)
                    .background(RoundedRectangle(cornerRadius: 20).stroke(Color.green, style: StrokeStyle(lineWidth: 2*zoom)))
                })
            }
            Spacer()
        }
        .frame(width: 410*zoom, height: 580*zoom)
        .clipped()
        .background(Color.black)
        .onAppear(){
            soundTest.volume = 0
            soundTest.playFromStart()
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage(currentPage: .constant(Pages.HomePage))
    }
}

struct CarRunning: View{
    @State private var carOffest:CGFloat = 270.0*zoom
    var timeSpeed: Double
    var body: some View{
        Image(uiImage: UIImage(named: "car.png")!)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(height: 60*zoom)
        .offset(x:carOffest)
        .onAppear(){
            withAnimation(Animation.linear(duration: timeSpeed).repeatForever(autoreverses: false)){
                carOffest = -270*zoom
            }
        }
        
    }
}
