import SwiftUI

struct SlotMachineView: View {
    let symbols = ["image", "image-1", "image-2", "image-3", "image 7351883"] // Символы заменены на названия ваших изображений
    
    @State private var slots = Array(repeating: Array(repeating: "image", count: 6), count: 5)
    @State private var credits = 99975.00
    @State private var betAmount = 50.00
    @State private var isAnimating = false
    @State private var isSettingsPresented = false
    @State private var isInfoPresented = false
    @State private var win = 0.0
    
    var body: some View {
        ZStack {
            // Фоновое изображение
            Image("1 6.5") // Замените на ваше фоновое изображение
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 10) {
                // Логотип и панель выигрыша
                HStack {
                    Spacer()
                    Image("image 7351884")
                    Spacer()
                }
                .padding(.top)
                
                // Слоты (5 рядов по 6 ячеек)
                VStack(spacing: 5) {
                    ForEach(0..<slots.count, id: \.self) { row in
                        HStack(spacing: 5) {
                            ForEach(0..<slots[row].count, id: \.self) { col in
                                Image(slots[row][col])
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .background(Color.white.opacity(0.3))
                                    .cornerRadius(5)
                                    .shadow(radius: 5)
                                    .scaleEffect(isAnimating ? 1.1 : 1.0)
                                    .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0.2), value: isAnimating)
                            }
                        }
                    }
                }
                .padding(.top, 10)
                
                // Панель с информацией
                
                ZStack {
                    Color.black.opacity(0.5)
                    
                    HStack {
                        Text("YOUR WIN ")
                            .font(.headline)
                            .foregroundColor(.yellow)
                        
                        Text("$\(win, specifier: "%.2f")")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                }
                .frame(width: UIScreen.main.bounds.width, height: 50)
                
                Spacer()
                
                // Панель управления
                HStack {
                    Button(action: {
                        isSettingsPresented.toggle()
                    }) {
                        Image(systemName: "gearshape.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 10) {
                        Button(action: {
                            spinSlots()
                        }) {
                            Image(systemName: "arrow.2.circlepath.circle.fill")
                                .resizable()
                                .frame(width: 70, height: 70)
                                .foregroundColor(.white)
                                .shadow(radius: 5)
                                .scaleEffect(isAnimating ? 1.1 : 1.0)
                                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0.2), value: isAnimating)
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        isInfoPresented.toggle()
                    }) {
                        Image(systemName: "info.circle")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                // Панель с информацией
                HStack {
                    Text("CREDIT ")
                        .font(.headline)
                        .foregroundColor(.yellow)
                    
                    Text("$\(credits, specifier: "%.2f")")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text("BET ")
                        .font(.headline)
                        .foregroundColor(.orange)
                    
                    Text("$\(betAmount, specifier: "%.2f")")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .padding(.vertical, 10)
                .background(Color.black.opacity(0.5))
                .cornerRadius(10)
                .padding(.horizontal, 20)
                .padding(.bottom, 50)
            }
            
            if isSettingsPresented {
                SettingsView(isPresented: $isSettingsPresented, credits: $credits, betAmount: $betAmount)
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
            }
            
            if isInfoPresented {
                GameRulesView(isPresented: $isInfoPresented, betAmount: $betAmount)
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
            }
        }
    }
    
    // Функция для вращения слотов
    func spinSlots() {
        win = 0.0
        
        isAnimating = true
        var symbolCounts: [String: Int] = [:]
        
        // Обновляем слоты случайными символами
        for row in 0..<slots.count {
            for col in 0..<slots[row].count {
                slots[row][col] = symbols.randomElement()!
                symbolCounts[slots[row][col], default: 0] += 1
            }
        }
        
        credits -= betAmount
        
        for (symbol, count) in symbolCounts {
            if count >= 4 {
                for row in 0..<slots.count {
                    for col in 0..<slots[row].count {
                        if slots[row][col] == symbol {
                            slots[row][col] = symbols.randomElement()!
                            symbolCounts[slots[row][col], default: 0] += 1
                        }
                    }
                }
                
                if count >= 12 {
                    win += betAmount * 25
                } else if count < 12 && count > 9 {
                    win += betAmount * 10
                } else {
                    win += betAmount * 2.5
                }
            }
        }
        
        credits += win
        
        // Завершаем анимацию
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isAnimating = false
        }
    }
}

struct SettingsView: View {
    @Binding var isPresented: Bool
    @Binding var credits: Double
    @Binding var betAmount: Double
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation {
                            isPresented.toggle()
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    }
                    .padding()
                }
                .background(Color.black.opacity(0.7))
                
                VStack(alignment: .leading) {
                    Text("SETTINGS")
                        .font(.headline)
                        .foregroundColor(.yellow)
                        .padding(.bottom, 20)
                    
                    Text("MAIN SETTINGS")
                        .font(.subheadline)
                        .foregroundColor(.orange)
                        .padding(.bottom, 10)
                    
                    
                    Toggle(isOn: .constant(false)) {
                        Text("MUSIC")
                            .foregroundColor(.white)
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .green))
                    
                    
                    HStack {
                        Text("HOME")
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        NavigationLink(destination: FasInsterView()) {
                            Image(systemName: "house.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                        }
                    }
                    
                    Divider()
                        .background(Color.orange)
                    
                    Text("BET SETTINGS")
                        .font(.subheadline)
                        .foregroundColor(.yellow)
                        .padding(.top, 10)
                    
                    HStack {
                        Button(action: {
                            betAmount -= 10
                        }) {
                            Image(systemName: "minus.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                        }
                        
                        Text("$\(betAmount, specifier: "%.2f")")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                        
                        Button(action: {
                            betAmount += 10
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.vertical, 20)
                }
                .padding()
                .background(Color.black.opacity(0.9))
                .cornerRadius(10)
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.7).edgesIgnoringSafeArea(.all))
        }
    }
}

struct GameRulesView: View {
    @Binding var isPresented: Bool
    @Binding var betAmount: Double
    
    var body: some View {
        ScrollView {
            HStack {
                Spacer()
                Button(action: {
                    withAnimation {
                        isPresented.toggle()
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                }
                .padding()
            }
            .background(Color.black.opacity(0.7))
            
            VStack(alignment: .center) {
                Text("GAME RULES")
                    .font(.headline)
                    .foregroundColor(.yellow)
                    .padding(.bottom, 20)
                
                HStack {
                    VStack {
                        Image("image")
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text("12+ $\(betAmount * 25, specifier: "%.2f")\n10 - 11 $\(betAmount * 10, specifier: "%.2f")\n8 - 9 $\(betAmount * 2.5, specifier: "%.2f")")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                    
                    VStack {
                        Image("image-1")
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text("12+ $\(betAmount * 25, specifier: "%.2f")\n10 - 11 $\(betAmount * 10, specifier: "%.2f")\n8 - 9 $\(betAmount * 2.5, specifier: "%.2f")")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                }
                
                HStack {
                    VStack {
                        Image("image-2")
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text("12+ $\(betAmount * 25, specifier: "%.2f")\n10 - 11 $\(betAmount * 10, specifier: "%.2f")\n8 - 9 $\(betAmount * 2.5, specifier: "%.2f")")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                    
                    VStack {
                        Image("image-3")
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text("12+ $\(betAmount * 25, specifier: "%.2f")\n10 - 11 $\(betAmount * 10, specifier: "%.2f")\n8 - 9 $\(betAmount * 2.5, specifier: "%.2f")")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                    
                    VStack {
                        Image("image 7351883")
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text("12+ $\(betAmount * 25, specifier: "%.2f")\n10 - 11 $\(betAmount * 10, specifier: "%.2f")\n8 - 9 $\(betAmount * 2.5, specifier: "%.2f")")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                }
                
                // Добавьте остальные символы аналогичным образом
                
                Text("Symbols pay anywhere on the screen.\nThe total number of identical symbols on the screen at the end of the spin determines the winning amount.")
                    .font(.footnote)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
            }
            .padding()
            .background(Color.black.opacity(0.9))
            .cornerRadius(10)
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.7).edgesIgnoringSafeArea(.all))
    }
}
