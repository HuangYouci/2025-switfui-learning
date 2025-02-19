//
//  FirstInfoView.swift
//  myProject01
//
//  Created by 黃宥琦 on 2025/2/19.
//

import SwiftUI

struct FirstInfoView: View {
    
    // --------------- //
    // EnvironmentObject
    @EnvironmentObject var data: UserDef
    // StateObject
    // Binding
    // State
    // --------------- //
    
    var body: some View {
        ScrollView {
            
            VStack{
                
                HStack{
                    Spacer()
                    Text("歡迎使用")
                        .font(.title)
                        .bold()
                    Spacer()
                }
                
                HStack{
                    Spacer()
                    Text("學測個申分析系統")
                        .font(.title)
                        .bold()
                    Spacer()
                }
                
                HStack{
                    Text("學測成績分析、科系資料詳情")
                        .font(.title2)
                }
                .padding(.vertical, 10)
                
                Image("clearlogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .shadow(color: Color.yellow, radius: 5, x: 5, y: 5)
            }
            .padding(.top, 80)
            .padding(.vertical, 100)
            Divider()
                .padding(.horizontal, 50)
            
            VStack{
                HStack {
                    Text("重點功能")
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 10)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack{
                        VStack{
                            HStack{
                                Text("輕鬆輸入成績資料，\n快速分析。")
                                    .font(.title3)
                                Spacer()
                            }
                            HStack {
                                Image("Info1")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 250)
                            }
                        }
                        .padding()
                        .background(Color(.systemGroupedBackground))
                        .cornerRadius(10)
                        VStack{
                            HStack{
                                Text("過去、現在、未來的所有分析，\n一覽無遺。")
                                    .font(.title3)
                                Spacer()
                            }
                            HStack {
                                Image("Info2")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 250)
                            }
                        }
                        .padding()
                        .background(Color(.systemGroupedBackground))
                        .cornerRadius(10)
                        VStack{
                            HStack{
                                Text("五星級評等校系落點分析，\n實在清晰。")
                                    .font(.title3)
                                Spacer()
                            }
                            HStack {
                                Image("Info3")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 250)
                            }
                        }
                        .padding()
                        .background(Color(.systemGroupedBackground))
                        .cornerRadius(10)
                        VStack{
                            HStack{
                                Text("以關鍵字鎖定，\n喜愛校系。")
                                    .font(.title3)
                                Spacer()
                            }
                            HStack {
                                Image("Info4")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 250)
                            }
                        }
                        .padding()
                        .background(Color(.systemGroupedBackground))
                        .cornerRadius(10)
                        VStack{
                            HStack{
                                Text("校系詳細資訊：名額、篩選、甄試，\n盡收眼底。")
                                    .font(.title3)
                                Spacer()
                            }
                            HStack {
                                Image("Info5")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 250)
                            }
                        }
                        .padding()
                        .background(Color(.systemGroupedBackground))
                        .cornerRadius(10)
                        VStack{
                            HStack{
                                Text("找到喜歡校系？成為最愛，\n堅定不移。")
                                    .font(.title3)
                                Spacer()
                            }
                            HStack {
                                Image("Info6")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 250)
                            }
                        }
                        .padding()
                        .background(Color(.systemGroupedBackground))
                        .cornerRadius(10)
                        .padding(.trailing, 50)
                    }
                }
                .padding(.trailing, -90)
            }
            .padding()
            
            VStack{
                HStack {
                    Text("關於本程式")
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                
                VStack{
                    VStack{
                        Image("logo")
                            .resizable() // 讓圖片可以縮放
                            .scaledToFit() // 保持圖片比例
                            .frame(width: 100, height: 100) // 設定大小
                            .clipShape(RoundedRectangle(cornerRadius: 20)) // 設定圓角
                            .padding()
                        
                        Text("學測個申分析系統")
                            .bold()
                        
                        Text("由 HYC 開發")
                        
                        Text("ycdev@icloud.com")
                        
                    }
                    .padding(10)
                    
                    Divider()
                    
                    HStack{
                        
                        Text("程式版本")
                            .foregroundColor(.accentColor)
                        
                        Spacer()
                        
                        Text("v1.0")
                        
                    }
                    .padding(5)
                    
                    Divider()
                    
                    HStack{
                        
                        Text("資料內容")
                            .foregroundColor(.accentColor)
                        
                        Spacer()
                        
                        Text("114年")
                        
                    }
                    .padding(5)
                }
                .padding(10)
                .background(Color(.systemGroupedBackground))
                .cornerRadius(10)
            }
            .padding()
            
            VStack{
                HStack {
                    Text("使用條款")
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                
                VStack{
                    
                    HStack{
                        Text("當您開始使用此程式，代表您已同意以下條款。")
                        Spacer()
                    }
                    .padding(10)
                    
                    VStack{
                        
                        ScrollView {
                            VStack(alignment: .leading, spacing: 10){
                                Text("歡迎使用本程式。本使用條款 (ToS) 規範您使用本程式的權利與義務，請在使用前詳細閱讀。如您不同意本條款，請勿使用本程式。")
                                Text("1. 服務說明")
                                    .bold()
                                Text("本程式提供學測落點分析服務，使用者可輸入學測成績資訊 (國文、英文、數A、數B、自然、社會)，以及其他特殊科目 (英文聽力、APCS、術科等)，程式將透過特定演算法分析各校各系的錄取機率，並提供相關科系資訊，包括錄取人數、面試人數、篩選條件、檢定條件、去年篩選結果、甄試須知等。")
                                Text("2. 資料來源與準確性聲明")
                                    .bold()
                                Text("本程式之資料來源為大考中心及各校各系官網。落點分析結果為開發者自行設計的演算法推估，僅供參考，無法保證其準確性。由於資料可能存在缺漏，某些科系可能無法提供落點分析結果，但仍可查閱基本資訊，並列於「無資料清單」內。有關於特殊科目處理方式：APCS (程設觀念、程設實作) 僅作為檢定比對，不計入篩選計算。另外，術科科目不進行檢定比對或篩選計算。使用者應自行比對資訊，開發者對於使用本程式所產生的任何結果或決策概不負責。")
                                Text("3. 使用者數據與隱私")
                                    .bold()
                                Text("本程式不會上傳使用者輸入的數據，所有資料僅儲存於本機。若使用者對資料存儲方式有疑慮，請勿使用本程式。「關於」頁面提供的「清除所有資料」功能，將刪除所有分析結果及透過廣告獲取的分析次數，請謹慎使用。")
                                Text("4. 付費贊助與廣告機制")
                                    .bold()
                                Text("使用者可透過觀看廣告來獲得一次落點分析機會，廣告收入將用於支撐本程式的開發與維護。使用者可透過小額購買來贊助開發，並解鎖無限次分析功能。 本程式不對廣告內容負責，若有不適廣告，請向廣告提供商檢舉。")
                                Text("5. 服務變更、終止與責任限制")
                                    .bold()
                                Text("開發者保留隨時修改、暫停或終止本程式服務的權利，無須事先通知。若因技術問題或其他不可抗力因素導致服務中斷，開發者不承擔任何責任。本程式僅供參考，對於使用者因落點分析結果而做出的任何決策，開發者概不負責。本程式的資訊可能因時間推移或官方政策變動而有所不同，使用者應自行查證最新資訊。")
                                Text("6. 聯絡開發者")
                                    .bold()
                                Text("請透過電子郵件：ycdev@icloud.com")
                            }
                        }
                        .frame(height: 400)
                        
                    }
                    .padding(10)
                    
                }
                .padding(10)
                .background(Color(.systemGroupedBackground))
                .cornerRadius(10)
            }
            .padding()
                
            if !data.notFirstUse {
                HStack {
                    Button(role: .none){
                        data.notFirstUse = true
                    } label: {
                        Spacer()
                        Text("開始使用")
                        Spacer()
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
            }
        }
        .padding()
    }
}
