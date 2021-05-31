//
//  ContentView.swift
//  TimeFlies
//
//  Created by Shaun Ku on 2021/4/8.
//

import SwiftUI

extension Double {
    func rounding(toDecimal decimal: Int) -> Double {
        let numberOfDigits = pow(10.0, Double(decimal))
        return (self * numberOfDigits).rounded(.toNearestOrAwayFromZero) / numberOfDigits
    }
}

struct GamePage: View {
    @Binding var currentPage:Pages
    @State private var totalLevel:Int = 4
    @State private var currentLevel:Int = 1
    @StateObject private var timer = GameTimer(targetTime: 4.00)
    @State private var result:String = "Welcome :)"
    @State private var resultColor:Color = Color(red: 51/255, green: 255/255, blue: 153/255)
    @State private var isWin:Bool = false
    @State private var show321:Bool = false
    @State private var textChange:Bool = false
    @State private var text321:String = " "
    @State private var showInteger:[Bool] = [false, false]
    @State private var stainOpacity:Double = 0.00
    @State private var previousStain:Double = 0.00
    @State private var curtainWidth:CGFloat = 0.00
    @State private var previousCurtain:CGFloat = 0.00
    func setTargetTime(){
        switch(currentLevel){
        case 1:
            timer.targetTime = 4.00
            break
        case 2:
            timer.targetTime = 9.00
            break
        case 3:
            timer.targetTime = 12.34
        case 4:
            timer.targetTime = 20.21
            break
        default:
            break
        }
    }
    func startGame(){
        result = " "
        timer.overTime = false
        timer.timeElapsed = 0.000
        resultColor = Color.orange
        previousStain = stainOpacity
        previousCurtain = curtainWidth
        show321 = true
        text321 = "3"
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0){
            text321 = "2"
            textChange.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now()+1.0){
                text321 = "1"
                textChange.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now()+1.0){
                    text321 = "Go!"
                    textChange.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now()+1){
                        text321 = " "
                        textChange.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
                            show321 = false
                            showInteger[1] = showInteger[0]
                            timer.timerStart()
                        }
                    }
                }
            }
        }
    }
    func endGame(){
        timer.timerStop()
        //timer.timeElapsed = 5.000
        //print("Target Time: \(timer.targetTime)")
        //print("Time Elapsed: \(timer.timeElapsed)")
        //print("Time Elapsed(rounded): \(timer.timeElapsed.rounding(toDecimal: 2))")
        showInteger[1] = false
        stainOpacity = 0
        curtainWidth = 0
        if(timer.timeElapsed.rounding(toDecimal: 2)==timer.targetTime){
            isWin = true
            result = "Fantastic :)"
            resultColor = Color.green
        }
        else{
            isWin = false
            if(abs(timer.targetTime-timer.timeElapsed)<=0.1){
                result = "So Close..."
                resultColor = Color.yellow
            }
            else{
                result = "Opps :(("
                resultColor = Color.red
            }
            
        }
    }
    var body: some View {
        VStack{
            let runningNshow = timer.isTimeRunning||show321
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
                HStack{
                    Button(action: {
                        currentLevel-=1
                        setTargetTime()
                    }, label: {
                        Image(systemName: "arrow.left")
                        .font(.system(size: 20*zoom, weight: .bold))
                        .foregroundColor(Color.pink)
                        .opacity(currentLevel==1||runningNshow ? 0 : 1)
                    })
                    .disabled(currentLevel==1||runningNshow)
                    Text("Level \(currentLevel)")
                    .font(Font.custom("GillSans-Bold", size: 20*zoom))
                    .foregroundColor(Color.white)
                    Button(action: {
                        currentLevel+=1
                        setTargetTime()
                    }, label: {
                        Image(systemName: "arrow.right")
                        .font(.system(size: 20*zoom, weight: .bold))
                        .foregroundColor(Color.pink)
                        .opacity(currentLevel==totalLevel||runningNshow ? 0 : 1)
                    })
                    .disabled(currentLevel==totalLevel||runningNshow)
                }
            }
            .padding(.top, 5)
            Spacer()
            HStack(spacing:0){
                Text("Stop the timer exactly at  ")
                .font(Font.custom("GillSans-Bold", size: 18*zoom))
                .foregroundColor(Color.white)
                Text("\(timer.targetTime, specifier: "%.2f")")
                .font(Font.custom("GillSans-Bold", size: 20*zoom))
                .foregroundColor(Color.yellow)
                .fontWeight(.bold)
                Text(" seconds!")
                .font(Font.custom("GillSans-Bold", size: 18*zoom))
                .foregroundColor(Color.white)
            }
            .multilineTextAlignment(.center)
            .frame(height: 50*zoom)
            VStack{
                if(show321){
                    Group{
                        if(textChange){
                            Text("\(text321)")
                        }
                        else{
                            Text("\(text321)")
                        }
                    }
                    .font(Font.custom("GillSans-Bold", size: 60*zoom))
                    .transition(AnyTransition.opacity.animation(.easeOut(duration:0.5)))
                    .foregroundColor(Color.purple)
                    .frame(height: 40*zoom, alignment: .center)
                    .padding(.bottom, 10*zoom)
                }
                else{
                    Text(timer.overTime ? "Time Exceeded" : "\(result)")
                    .font(Font.custom("GillSans-Bold", size: 40*zoom))
                    .fontWeight(.bold)
                    .foregroundColor(resultColor)
                    .multilineTextAlignment(.center)
                    .frame(height: 40*zoom)
                    .padding(.bottom, 10*zoom)
                }
            }
            ZStack{
                Text("\(showInteger[1] ? Double(Int(timer.timeElapsed)) : timer.timeElapsed, specifier: "%.2f") s")
                .font(Font.custom("GillSans-Bold", size: 70*zoom))
                .fontWeight(.bold)
                .foregroundColor(timer.timeElapsed.rounding(toDecimal: 2)==timer.targetTime ? Color.green : (timer.timeElapsed-2*timer.targetTime)>=0 ? Color.orange : (timer.targetTime-timer.timeElapsed)>2.0 ? Color.white : Color.red)
                .multilineTextAlignment(.center)
                .padding(.bottom, 10*zoom)
                .opacity(timer.timeDisappear ? 0 : 1)
                .animation(timer.timeDisappear ? .easeIn(duration: 0.8) : nil)
                Image(uiImage: UIImage(named: "inkStain.png")!)
                .resizable()
                .frame(width: 300*zoom, height: 80*zoom)
                .scaledToFit()
                .offset(x:-10*zoom, y:0)
                .rotationEffect(.degrees(-15))
                .opacity(stainOpacity)
                HStack{
                    Image(uiImage: UIImage(named: "curtain.png")!)
                    .resizable()
                    .frame(width: curtainWidth*zoom, height: 100*zoom)
                    .scaledToFit()
                    Spacer()
                    .frame(minWidth: 0*zoom)
                    Image(uiImage: UIImage(named: "curtain.png")!)
                    .resizable()
                    .frame(width: curtainWidth*zoom, height: 100*zoom)
                    .scaledToFit()
                }
            }
            .frame(height: 100*zoom)
            HStack{
                Button(action:{
                    startGame()
                }, label: {
                    Text("Start Timer")
                    .foregroundColor(Color.blue)
                    .font(Font.custom("GillSans-Bold", size: 28*zoom))
                    .multilineTextAlignment(.center)
                    .frame(width:190*zoom, height: 60*zoom)
                    .background(RoundedRectangle(cornerRadius: 20).stroke(Color.blue, style: StrokeStyle(lineWidth: 2*zoom)))
                    .opacity(runningNshow ? 0.3 : 1)
                })
                .disabled(runningNshow)
                .padding(.trailing, 10*zoom)
                
                Button(action:{
                    endGame()
                }, label: {
                    Text("Stop Timer")
                    .foregroundColor(Color.red)
                    .font(Font.custom("GillSans-Bold", size: 28*zoom))
                    .multilineTextAlignment(.center)
                    .frame(width:190*zoom, height: 60*zoom)
                    .background(RoundedRectangle(cornerRadius: 20).stroke(Color.red, style: StrokeStyle(lineWidth: 2*zoom)))
                    .opacity(!timer.isTimeRunning||show321 ? 0.3 : 1)
                })
                .disabled(!timer.isTimeRunning||show321)
            }
            .padding(.bottom, 10*zoom)
            VStack{
                HStack{
                    Button(action: {
                        stainOpacity =  previousStain
                        curtainWidth = previousCurtain
                    }, label: {
                        Image(systemName: "clock.arrow.circlepath")
                        .font(.system(size: 20*zoom, weight: .bold))
                        .foregroundColor(Color.white)
                    })
                    .disabled(runningNshow)
                    .padding(EdgeInsets(top: 10*zoom, leading: 10*zoom, bottom: 0, trailing: 0))
                    Spacer()
                    Text("Game Parameters")
                    .font(Font.custom("GillSans-Bold", size: 18*zoom))
                    .foregroundColor(.white)
                    .padding(.top, 10*zoom)
                    Spacer()
                }
                VStack(alignment: .leading){
                    Toggle("Sound Hint:", isOn: $timer.soundHint)
                    .font(Font.custom("GillSans-Bold", size: 14*zoom))
                    .foregroundColor(.white)
                    .disabled(runningNshow)
                    .padding(EdgeInsets(top: 0, leading: 10*zoom, bottom: 0, trailing: 10*zoom))
                    
                    Toggle("Only Show Integer:", isOn: $showInteger[0])
                    .font(Font.custom("GillSans-Bold", size: 14*zoom))
                    .foregroundColor(.white)
                    .disabled(runningNshow)
                    .padding(EdgeInsets(top: 0, leading: 10*zoom, bottom: 0, trailing: 10*zoom))
                    
                    HStack{
                        Text("Ink Stain: ")
                        .font(Font.custom("GillSans-Bold", size: 14*zoom))
                        .foregroundColor(.white)
                        Image(systemName: "sun.min")
                        .font(.system(size: 20*zoom))
                        .foregroundColor(Color.white)
                        Slider(value: $stainOpacity, in: 0...1, step: 0.01){}
                        .disabled(runningNshow)
                        Image(systemName: "sun.max.fill")
                        .font(.system(size: 20*zoom))
                        .foregroundColor(Color.white)
                    }
                    .padding(EdgeInsets(top: 0, leading: 10*zoom, bottom: 0, trailing: 10*zoom))
                    
                    HStack{
                        Text("Curtains: ")
                        .font(Font.custom("GillSans-Bold", size: 14*zoom))
                        .foregroundColor(.white)
                        Slider(value: $curtainWidth, in: 0...205, step: 1,minimumValueLabel: Text("Open").font(Font.custom("GillSans-Bold", size: 14*zoom)).foregroundColor(.white), maximumValueLabel: Text("Close").font(Font.custom("GillSans-Bold", size: 14*zoom)).foregroundColor(.white)){}
                        .disabled(runningNshow)
                    }
                    .padding(EdgeInsets(top: 0, leading: 10*zoom, bottom: 0, trailing: 10*zoom))
                    
                    HStack{
                        Spacer()
                        Text("Timer Disappear \(timer.disappearTime, specifier: "%.2f") Second(s) Before Target")
                        .font(Font.custom("GillSans-Bold", size: 13*zoom))
                        .foregroundColor(.white)
                        let plusDisable = abs(timer.disappearTime-5.000)<=0.001||runningNshow
                        let minusDisable = abs(timer.disappearTime-0.000)<=0.001||runningNshow
                        Button(action:{timer.disappearTime+=1.000}, label: {
                            Text("+")
                            .foregroundColor(plusDisable ? .gray : .white)
                            .frame(width: 20*zoom)
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(plusDisable ? Color.gray : Color.white, style: StrokeStyle(lineWidth: 2*zoom)))
                        })
                        .disabled(plusDisable)
                        Button(action:{timer.disappearTime-=1.000}, label: {
                            Text("-")
                            .foregroundColor(minusDisable ? .gray : .white)
                            .frame(width: 20*zoom)
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(minusDisable ? Color.gray : Color.white, style: StrokeStyle(lineWidth: 2*zoom)))
                        })
                        .disabled(minusDisable)
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 0, leading: 10*zoom, bottom: 10*zoom, trailing: 10*zoom))
                }
            }
            .frame(width:400*zoom)
            .background(RoundedRectangle(cornerRadius: 20).stroke(Color(red: 153/255, green: 204/255, blue: 255/255), style: StrokeStyle(lineWidth: 2*zoom)))
            .padding(.bottom, 10*zoom)
        }
        .frame(width: 410*zoom, height: 580*zoom)
        .background(Color.black)
        .onDisappear(){
            timer.timerStop()
        }
    }
}

struct GamePage_Previews: PreviewProvider {
    static var previews: some View {
        GamePage(currentPage: .constant(Pages.GamePage))
    }
}
