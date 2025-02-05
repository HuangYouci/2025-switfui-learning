# SwiftUI 新手入門

[TOC]

<!-- 本筆記是學習 Swift 與 SwiftUI 的內容。 -->

## SwiftUI 基本架構、預設專案介紹

**專案建立與基本架構**

-   **建立新專案**：在 Xcode 中，選擇 iOS 的 App 模板，並命名專案（例如：FoodPicker）。設定組織的 Identifier（Organization Identifier），慣用寫法為將網域反過來寫，若無網域則可使用 `com.你的名字`。**務必選擇 SwiftUI 作為介面，並使用 Swift 語言。**
    
-   **專案結構**：Xcode 會自動產生一些預設檔案。
    
    -   `ContentView.swift`：主要的程式碼檔案，其中 `ContentView` 是一個 **struct**，遵循 **View** 協定（**Protocol**）。
    -   **View 協定**：任何遵循 `View` 協定的類型都可以在畫面上顯示。`View` 協定要求必須有一個 **`body` 屬性**，用來描述畫面長相。
    -   **預覽畫面 (Preview)**：Xcode 提供即時預覽功能，可以預覽不同裝置、深淺模式、螢幕方向，以及字體大小的效果。
        -   **Live View**：模擬實際互動情況。
        -   **Selectable**：點擊預覽畫面上的元素，程式碼會自動選取。
        -   **Variant**：快速比較不同情境，例如深色模式（Dark Mode）、淺色模式（Light Mode）、橫向 (landscape) / 直向 (portrait) 螢幕、字體大小 (dynamic type) 等。
        -   預覽畫面並非直接從 struct 產生，而是透過 **`PreviewProvider`** 建立。
        -   若看不到預覽，可能是 canvas 被關閉了。
-   **專案導覽器 (Navigator)**：顯示專案中的所有檔案。
    
    -   最上層的藍色 icon 代表整個專案的設定。
    -   專案設定分為 **project** 和 **target**。
        -   一個專案可能有多個 target，例如免費版、付費版、測試版，或是針對不同平台的版本 (例如 watchOS)。

**專案設定 (Project Settings)**

-   **Project 設定**：主要設定整個專案最低支援的 iOS 版本。
    -   練習專案可選擇最新的 iOS 版本。
-   **Targets 設定**：設定特定 target 的相關設定。
    -   可設定支援的裝置 (例如：iPhone, iPad, Mac)。
    -   可設定此 target 最低支援的 iOS 版本。
    -   App 的分類、顯示名稱、辨識 ID（Bundle Identifier）、版本號碼等。
    -   **可設定 App 支援的螢幕方向**：是否支援橫向顯示。
        -   一般來說，只有影片或遊戲才會需要橫向。
        -   在 iPad 上，螢幕轉向的影響較小。
    -   **狀態列顏色**：可設定深色模式和淺色模式下的狀態列顏色。
    -   是否全螢幕顯示。

**App 的進入點 (Entry Point)**

-   **`@main` 標籤**: 標記 App 的進入點。
-   **`App` 協定**: 作為 App 的進入點，必須遵循 `App` 協定。
-   **`body` 屬性**: `App` 協定要求必須在 `body` 屬性中設定一個 **`Scene` 類型**。
-   **`WindowGroup`**: 通常使用 `WindowGroup` 作為 `Scene` 的類型。
    -   `WindowGroup` 負責管理視窗。
    -   在 `WindowGroup` 裡面放置的 `View`，就是視窗開啟時顯示的畫面，也就是最底層的畫面。
-   **App, Scene, View 的關係**:
    -   **App**: 管理整個應用程式的生命週期，知道它的視窗是什麼。
    -   **Scene**: 管理視窗，知道每個視窗的初始畫面，並處理在不同平台上視窗的開關。
    -   **View**: 描述畫面的外觀，讓畫面在不同裝置上正確顯示。
    -   它們都是 **Protocol**。只要遵循這些 protocol，就可以獲得對應的功能。
    -   之所以需要 App -> Scene -> View 的層級結構，是因為一個 App 可能有多個視窗。
        -   不同視窗可能需要有獨立的狀態。
        -   同一個 App 的不同視窗也可能需要共享一些狀態 (例如：登入狀態)。

**其他重要的資料夾**

-   **Assets**：放置圖片、資料、顏色設定、App icon 等檔案。
-   **Preview Content**: 放置開發時使用的示範圖片和資料，在打包成正式 App 時會自動排除。

**iOS 版本支援**

-   **學習時**：可直接使用最新的 iOS 版本。
-   **App 上架時**：最少要向下支援一個版本。
    -   例如：現在是 iOS 16，最少要支援到 iOS 15。
    -   使用者升級到新版本需要時間。
    -   向下支援可以確保更多使用者可以使用 App。
    -   是否要支援更舊的版本，要根據使用者數量和維護成本決定。

**簡單程式碼範例**

```swift=
// ContentView.swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello Baby") // 顯示 "Hello Baby" 文字
            .font(.largeTitle) // 設定字體大小
    }
}

// App 進入點 (你的App名稱App.swift)
import SwiftUI

@main
struct FoodPickerApp: App { // "FoodPickerApp" 為你的 App 名稱
    var body: some Scene {
        WindowGroup {
            ContentView() // 視窗開啟時顯示 ContentView
        }
    }
}

```

這段程式碼展示了 `ContentView` 如何顯示文字，以及 App 的進入點如何設定要顯示的初始畫面。

## View 和 Modifier 介紹

**View (視圖)**

-   **View Protocol (視圖協定)**：任何遵循 `View` 協定的類型都可以在畫面上顯示。
    
    -   **`body` 屬性**：`View` 協定要求必須有一個 `body` 屬性，用來描述畫面長相，而這個 `body` 的類型也是某一種 `View`。
    -   **View 的組成**：實際上，我們不會從無到有宣告一個 `View`，而是使用 SwiftUI 內建的 `View` 來設計。例如：`VStack`、`Image`、`Text` 等。
    -   可以把 View 的概念想像成料理，每個組合（包含組合前和組合後）都還是食物，像是珍珠奶茶，珍珠、牛奶、糖、紅茶都是食物，將它們組合起來的珍奶也是食物。
    -   要做出一個 View，需要知道：
        -   有哪些 **View** 可以用。
        -   **View** 可以做什麼變化 (modifier)。
        -   怎麼組合和排序 (Layout)。
-   **內建 View**：
    
    -   可以透過 Xcode 右上角的加號或快捷鍵 `Command + Shift + L` 來查看可用的 View。
    -   View 分為不同類別，例如：
        -   **控制元件 (Controls)**：按鈕、顏色選擇器、日期選擇器等。
        -   **排版 (Layout)**：用於排列其他 View 的 View，如 `VStack`、`HStack`。
        -   **繪圖 (Paint)**：漸層效果。
        -   **形狀 (Shapes)**、顏色、分隔線等。
    -   可以點擊 View 查看詳細文件。
    -   使用 View 時要注意最低支援的 iOS 版本。

**Modifier (調整器)**

-   **定義**：Modifier 是一種可以對 View 做調整的方法，就像料理時的調味或烹飪方式。
-   **功能**：可以改變 View 的外觀和行為，例如：
    -   文字大小、顏色。
    -   圖片大小。
    -   邊距 (padding)。
    -   對齊方式。
    -   間距。
    -   字型。
    -   輔助模式 (Accessibility) 設定。
    -   手勢。
-   **使用方式**：在 View 後面加上 `.modifierName()` 來使用，例如：`.font(.largeTitle)`、`.foregroundColor(.accentColor)`。
-   **種類**：Modifier 分為多種類別，例如：
    -   **控制 (Controls)** 相關的 modifier。
    -   **特效 (Effects)**。
    -   **排版 (Layout)** 相關的 modifier。
    -   **文字 (Text)** 相關的 modifier。
    -   **圖片 (Image)** 相關的 modifier。
    -   **清單 (List)** 相關的 modifier。
    -   **導覽 (Navigation)** 相關的 modifier。
    -   **風格 (Style)** 相關的 modifier。
    -   **輔助模式 (Accessibility)** 相關的 modifier。
    -   **事件 (Events)** 和 **手勢 (Gestures)** 相關的 modifier。
    -   **形狀 (Shape)** 相關的 modifier。
-   **重點**：Modifier 的數量非常多，不需要刻意記憶，常用的會自然記住。

**Layout (排版)**

-   **定義**：Layout 是一種用於排列 View 的方式，決定 View 在畫面上的位置和順序，就像料理時的擺盤。
-   **例子**：
    -   **`VStack` (Vertical Stack)**：垂直排列 View。
    -   **`HStack` (Horizontal Stack)**：水平排列 View。
-   **排版也是 View 的一種**：雖然 Layout 的目的是排列其他 View，但它本身也是一個 View。
-   **組合方式**：在 `VStack` 中放入 View 時，View 會按照垂直方向排列。

**程式碼範例**

```swift=
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack { // 使用 VStack 垂直排列
            Image(systemName: "star.fill") // 顯示一個星星的圖片
                .font(.system(size: 50)) // 設定圖片大小
                .foregroundColor(.yellow) // 設定圖片顏色

            Text("Hello Baby") // 顯示文字 "Hello Baby"
                .padding() // 設定邊距
        }
    }
}

```

這個範例展示了如何使用 `VStack` 來排列 `Image` 和 `Text`，並使用 modifier 來調整它們的外觀。

**其他工具**

-   **Code Snippets (程式碼片段)**：可以自己設定或使用預設的程式碼片段，快速生成程式碼。
    -   例如：輸入 `if` 會自動跳出 if 條件式的程式碼。
-   **Assets**：放置圖片、顏色等資源。
    -   每個 App 都有一個強調色 (accent color)，預設為藍色。
-   **SF Symbols**：Apple 提供的圖示，可直接在 App 中使用。
    -   使用時要注意圖示的最低版本限制。

## 實作第一個畫面：今天吃什麼

**圖片 (Image)**

-   **加入圖片到專案 (Add Image to Project)**：
    -   將圖片拖曳到 **Assets** 資料夾中。
    -   在 **Assets** 中可以修改圖片名稱，這個名稱會用在程式碼中識別圖片。
-   **在程式碼中使用圖片 (Use Image in Code)**：
    -   可以使用 `Image("圖片名稱")` 來顯示圖片。
        -   如果使用 `systemName` 參數，則是使用 **SF Symbols** (Apple 提供的圖示)，例如：`Image(systemName: "globe")`。
    -   使用 `Image("圖片名稱")` 會到 **Assets** 中尋找對應名稱的圖片。
    -   使用 `Image(systemName: "圖示名稱")` 則會使用 Apple 提供的 **SFSymbols**。
-   **圖片大小調整 (Resize Image)**：
    -   預設情況下，圖片會以原始大小顯示。
    -   使用 `.resizable()` **調整器 (modifier)** 可以讓圖片變成可調整大小。
    -   使用 `.scaledToFill()` 或 `.scaledToFit()` **調整器 (modifier)** 可以讓圖片在維持長寬比的情況下填滿或適應畫面。
        -   `.scaledToFill()` 會在維持長寬比的情況下填滿整個空間，可能會超出邊界。
        -   `.scaledToFit()` 會在維持長寬比的情況下，完整顯示圖片在可視範圍內。
    -   使用 `.frame(width: CGFloat, height: CGFloat)` **調整器 (modifier)** 可以設定圖片的寬度和高度。
-   **Render Mode (渲染模式)**:
    -   `template` 模式會將圖片轉為類似模型，可以用顏色填滿，適合用在 icon 上，並改變其顏色。
    -   `original` 模式會顯示圖片原始的顏色，通常為預設選項。

**文字 (Text)**

-   **顯示文字 (Display Text)**：
    -   使用 `Text("文字內容")` 來顯示文字。
-   **文字樣式調整 (Adjust Text Style)**：
    -   使用 `.font(Font.字體大小)` 來設定文字大小，例如：`.font(.largeTitle)` 或 `.font(.system(size: 30))`。
        -   `.largeTitle` 等是系統預設好的字體大小。
    -   使用 `.fontWeight(.粗細)` 來設定文字粗細，例如：`.fontWeight(.bold)` 或 `.fontWeight(.medium)`。
    -   `.font()` 可以搭配更多參數使用來做更細緻的調整，例如字體粗細、等寬數字、斜體等等。
    -   使用 `.foregroundColor(Color.顏色)` 來設定文字顏色，例如：`.foregroundColor(.green)`。

**排版 (Layout) - VStack 和 HStack**

-   **VStack (Vertical Stack)**：垂直排列 View。
    -   `VStack` 可以設定 **spacing (間距)** 參數，調整 View 之間的距離，例如：`VStack(spacing: 30)`。
-   **HStack (Horizontal Stack)**：水平排列 View。
-   **Stack 的嵌套 (Nested Stacks)**: 可以將 `VStack` 和 `HStack` 互相嵌套使用，建立更複雜的排版。
-   **當 body 裡面有多個 View 時**:
-   body 裡面只能回傳一個 View，如果直接回傳兩個 View，SwiftUI 會將他們分成兩個畫面來顯示，而非如預期地將兩個 View 在同一個畫面上顯示。
-   可以用 `VStack` 或 `HStack` 將多個 View 包裹起來，形成一個 View。

**按鈕 (Button)**

-   **建立按鈕 (Create Button)**：
    -   最簡單的寫法： `Button("按鈕文字") { /* 按下按鈕後執行的程式碼 */ }`。
    -   更彈性的寫法：`Button(action: { /* 按下按鈕後執行的程式碼 */ }, label: { /* 按鈕的畫面 */ })`。
        -   `label` 可以放入任何的 **View**，自訂按鈕外觀。
        -   可以在 `label` 中使用 `.frame` **調整器 (modifier)** 來設定按鈕的大小。
            -   `frame` 並不是將 View 本身拉伸，而是提供一個空間給它。
            -   `frame` 可以搭配 `alignment` 參數來設定 View 在空間中的對齊方式。
-   **按鈕樣式 (Button Style)**：
    -   使用 `.buttonStyle(.樣式)` 可以設定按鈕的樣式，例如：`.buttonStyle(.bordered)` 或 `.buttonStyle(.borderedProminent)`。
        -   `.bordered` 會在按鈕旁加上一些 **padding (邊距)**，並將按鈕變成圓角矩形。
        -   `.borderedProminent` 會將整個按鈕背景變成強調色。
-   **按鈕角色 (Button Role)**：
    -   使用 `role` 參數可以設定按鈕的角色，例如：`role: .cancel` 或 `role: .destructive`。
        -   `.cancel` 通常用在取消動作的按鈕上。
        -   `.destructive` 通常用在會刪除資料等危險操作的按鈕上，按鈕會變成紅色。
-   **按鈕形狀 (Button Shape)**：
    -   使用 `.buttonBorderShape(.形狀)` 可以設定按鈕的形狀，例如：`.buttonBorderShape(.capsule)`。
-   **控制器大小 (Control Size)**：
    -   使用 `.controlSize(.大小)` 可以設定按鈕的大小，例如：`.controlSize(.large)`。

**調整器 (Modifier)**

-   **使用方式**：`.modifierName(parameters)`，例如：`.padding(10)`、`.font(.title)`。
-   **調整器的順序 (Order of Modifiers)**：調整器的順序會影響最終呈現的結果。
    -   像是字體這種「選一個」的調整器，如果已經設定過了，後面的設定不會覆蓋前面的設定。
    -   像是 `padding` 這種留白大小的調整器，會疊加起來。
-   **常用的調整器**：
    -   `.padding()`：設定邊距。
    -   `.font()`：設定字體。
    -   `.fontWeight()`：設定字體粗細。
    -   `.foregroundColor()`：設定顏色。
    -   `.frame()`：設定 View 的大小。
    -   `.buttonStyle()`：設定按鈕樣式。
    -   `.buttonBorderShape()`: 設定按鈕形狀。
    -   `.controlSize()`: 設定控制元件大小。
    -   `.resizable()`：讓圖片變成可調整大小。
    -   `.scaledToFit()` / `.scaledToFill()`：讓圖片在維持長寬比的情況下適應畫面。
    -   `.animation()`：設定動畫效果。

**狀態管理 (State Management)**

-   **`@State` Property Wrapper**：
    -   使用 `@State` 可以讓 **value type** 的屬性，在數值改變時通知 SwiftUI 更新畫面。
    -   `@State` 可以將 **value type** 包裝成 **reference type**，在內部修改值的時候不會影響 struct 本身。
    -   通常會將 `@State` 設為 `private`，確保它只屬於這個 View。

**條件式顯示 (Conditional Display)**

-   **if 子句**：可以使用 `if` 子句來決定是否顯示某個 View。
    -   例如，只有當 `selectedFood` 不是空的時候才顯示，`if !selectedFood.isEmpty { Text(selectedFood) }`。

**動畫 (Animation)**

-   **`animation()` 調整器**：
    -   使用 `.animation(動畫曲線, value: 變化的值)` 可以讓畫面在資料改變時產生動畫效果。
    -   動畫曲線 (Animation Curve) 可以選擇不同的效果，如 `.easeOut`、`.easeInOut`、`.linear` 或 `.spring`。
        -   `.easeInOut` 在開始和結束時都有較柔和的動畫。
    -   `value` 參數是要觀察變化的資料，當這個資料發生變化時，SwiftUI 就會自動產生動畫。
    -   `animation()` 調整器的位置很重要，它必須放在要觀察的資料發生變化之前，通常會放在包含要產生動畫效果的 View 的最外層 View 上。

**強調色 (Accent Color)**

-   **設定強調色**：可以在 **Assets** 中設定 App 的強調色。
    -   強調色會影響許多預設的 UI 元件顏色，例如按鈕。
    -   可以針對 **淺色模式 (Light Mode)** 和 **深色模式 (Dark Mode)** 設定不同的強調色。

**背景顏色 (Background Color)**

-   **使用 `background()` 調整器**: 可以設定 View 的背景顏色。
    -   `background()` 接受的是 UIKit 的 `UIColor` 而非 SwiftUI 的 `Color`。
    -   可以使用 `UIColor.label`、`UIColor.secondaryBackground` 等來設定背景顏色。
-   **設定畫面填滿**: 若要設定背景填滿整個畫面，需要設定 View 的 `frame`，並使用 `maxHeight: .infinity` 讓高度填滿。

**程式碼範例**

```swift=
import SwiftUI

struct ContentView: View {
    @State private var selectedFood: String = ""
    let foods = ["牛肉麵", "雞腿便當", "滷肉飯", "水餃"]

    var body: some View {
        VStack(spacing: 30) {
            Image("dinner") // 顯示名為 dinner 的圖片
                .resizable() // 讓圖片可以調整大小
                .scaledToFit() // 讓圖片在維持長寬比的情況下適應畫面
                .frame(width: 200) // 設定圖片寬度

            Text("今天吃什麼") // 顯示文字
                .font(.title) // 設定字體大小

            if !selectedFood.isEmpty { // 只有當 selectedFood 不是空的時候才顯示
                Text(selectedFood) // 顯示選擇的食物
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
            }

            Button(action: { // 按鈕
                selectedFood = foods.shuffled().first ?? ""
            }, label: {
                Text(selectedFood.isEmpty ? "告訴我" : "換一個")
                    .frame(width: 200) // 設定文字寬度
            })
            .buttonStyle(.borderedProminent) // 設定按鈕樣式
            .controlSize(.large) // 設定控制元件大小
            .buttonBorderShape(.capsule) //設定按鈕形狀

            Button(action: {
                selectedFood = ""
            }, label: {
                Text("重置")
                    .frame(width: 200)
            })
            .buttonStyle(.bordered)
             .controlSize(.large)
            .buttonBorderShape(.capsule) //設定按鈕形狀

        }
        .padding()
        .animation(.easeInOut, value: selectedFood) // 設定動畫
        .background(Color(UIColor.secondarySystemBackground))//設定背景顏色
        .frame(maxHeight: .infinity)
       .font(.title) //設定字體
    }
}

```

這個程式碼範例展示了如何使用 `Image`、`Text` 和 `Button`，如何使用 `@State` 來管理狀態，如何使用條件式顯示，以及如何加入動畫。

## 動畫的產生 & View 的身份概念

**SwiftUI 動畫機制 (Animation Mechanism)**

-   當使用 **`animation()` 調整器 (modifier)** 監控的值發生變化時，SwiftUI 會自動為受影響的 **View** 建立動畫。
-   **動畫曲線 (Animation Curve)**：`.animation()` 調整器可以設定動畫的時間長度和變化速率，例如 `easeIn`、`easeOut` 或 `easeInOut`。
-   **動畫類型**：SwiftUI 會根據 **View** 的變化來決定使用哪種動畫類型，主要分為兩種：
    -   **變形動畫 (Transformation Animation)**：當 **View** 在畫面上的位置、大小等屬性發生改變時使用，例如移動、縮放。
    -   **轉場動畫 (Transition Animation)**：當 **View** 本身被替換成另一個 **View** 時使用，例如淡入淡出。
-   **判斷是否為同一個 View**：
    -   SwiftUI 使用 **View** 的身份 (Identity) 來判斷變化前後是否為同一個 **View**。
    -   **View** 的身份判斷首先會比較 **結構位置 (Hierarchy)**，也就是 **View** 在畫面結構中的位置。
        -   **結構位置 (Hierarchy)** 指的是 **View** 在 **VStack**、**HStack** 等容器中的嵌套關係。
        -   如果結構位置不同，則視為不同的 **View**，會使用轉場動畫。
        -   如果結構位置相同，則會進一步比較 **ID**。
    -   **ID (Identifier)**：如果 **View** 的 **ID** 不同，則視為不同的 **View**，也會使用轉場動畫。
        -   可以使用 `.id()` 調整器來設定 **View** 的 **ID**。

**轉場動畫 (Transition Animation)**

-   **預設轉場效果**：淡入淡出 (Fade In/Out)。
-   **觸發條件**：
    -   當 **View** 從無到有或從有到無時。
    -   當 **View** 在結構位置上被替換成另一個 **View** 時。
    -   當 **View** 的 **ID** 發生改變時。
-   **自訂轉場效果 (Customize Transition)**：
    -   可以使用 `.transition()` 調整器來設定不同的轉場效果。
    -   內建的轉場效果包括：`.opacity` (透明度)、`.scale` (縮放)、`.slide` (滑動) 等。
    -   可以組合多個轉場效果，例如：`.transition(.scale.combined(.slide))`。
    -   可以使用 `.asymmetric(insertion: , removal:)` 來分別設定進場 (insertion) 和離場 (removal) 的動畫。
-   **使用 `animation()` 設定轉場動畫**
-   轉場動畫的 `animation()` 設定會覆蓋外層的 `animation()` 設定。
-   若要獨立設定轉場動畫的動畫曲線和延遲，可以在 `transition()` 中使用 `.animation()`。
-   **轉場動畫的時序控制**
    -   可以使用 `delay` 來控制動畫延遲開始的時間.
    -   透過延遲進場動畫開始的時間，可以創造出先淡出再淡入的效果。

**變形動畫 (Transformation Animation)**

-   **預設行為**：SwiftUI 會嘗試對 **View** 的屬性進行變形動畫，例如位置、大小、旋轉等。
-   **觸發條件**：當 **View** 的屬性發生變化，但 **View** 本身沒有被替換時。
-   **例外情況**：
    -   當 SwiftUI 不知道如何進行變形時，例如文字內容的改變，預設會使用淡入淡出。
    -   在 iOS 16 之前，遇到 SwiftUI 不會的變形時，預設行為是直接切換，而不是淡入淡出。
-   **強制進行變形**：
    -   可以使用 `.transformEffect()` 調整器來強制 SwiftUI 進行變形動畫。
    -   例如，使用 `.transformEffect(.offset(x: 50, y: 0))` 可以讓 **View** 水平移動 50 個像素。
    -   使用 `.transformEffect(.identity)` 可以讓 **View** 維持原本的位置，避免被 SwiftUI 強制改成開始或結束的位置。
-   **當 SwiftUI 不知道怎麼變形時**:
    -   會直接將變化前的畫面淡出，同時將變化後的畫面淡入.
    -   此時會忽略其他可以掌握的變化.

**View 的結構位置 (Hierarchy) 與身份 (Identity)**

-   **結構位置 (Hierarchy)** 指的是 **View** 在 **View** 結構中的嵌套關係，例如在 **VStack** 或 **HStack** 內的順序。
-   **View** 的身份 (Identity) 不像 class 那樣有固定的身份，而是根據結構位置和 **ID** 來判斷。
-   當 **View** 的結構位置改變時，SwiftUI 會認為是不同的 **View**，會使用轉場動畫。
-   **`if` 子句 (if Statement)**：
    -   `if` 子句會將不同的分支包裝成不同的 **View**，即使內容相似，也會被視為不同的 **View**。
    -   `if else` 的本質是流程控制，會建立兩個獨立的畫面.
    -   因此，使用 `if` 子句進行條件式顯示時，預設會使用轉場動畫.
-   **條件運算子 (Ternary Operator)**：
    -   條件運算子 `condition ? value1 : value2` 會根據條件選擇一個值，但不會改變 **View** 的類型。
    -   因此，使用條件運算子進行條件式顯示時，會使用變形動畫。
-   **`EitherView`**:
    -   當 `if` 子句中沒有 `else` 時，SwiftUI 會使用 `EitherView` 來包裝，讓程式碼符合 **View** 的要求。
    -   `EitherView` 並不是一個實際的 **View**，而是 Swift 對不同類型 **View** 的一種包裝方式。
    -   使用 `EitherView` 包裝後，每個 `if` 子句的分支都會被視為不同的結構位置。

**程式碼範例**

```swift=
import SwiftUI

struct ContentView: View {
    @State private var selectedFood: String = ""
    let foods = ["牛肉麵", "雞腿便當", "滷肉飯", "水餃"]

    var body: some View {
        VStack(spacing: 30) {
            Image("dinner")
                .resizable()
                .scaledToFit()
                .frame(width: 200)

            Text("今天吃什麼")
                .font(.title)

            // 使用條件運算子，會產生變形動畫
            Text(selectedFood.isEmpty ? "請選擇" : selectedFood)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.green)

            Button(action: {
                selectedFood = foods.shuffled().first ?? ""
            }, label: {
                Text(selectedFood.isEmpty ? "告訴我" : "換一個")
                    .frame(width: 200)
            })
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .buttonBorderShape(.capsule)
            // 強制文字做變形動畫
            .transformEffect(.identity)
            // 關閉按鈕文字的動畫
            .animation(nil, value: selectedFood)

            Button(action: {
                selectedFood = ""
            }, label: {
                Text("重置")
                    .frame(width: 200)
            })
            .buttonStyle(.bordered)
            .controlSize(.large)
            .buttonBorderShape(.capsule)
        }
        .padding()
        .animation(.easeInOut, value: selectedFood)
        .background(Color(UIColor.secondarySystemBackground))
        .frame(maxHeight: .infinity)
        .font(.title)
        // 加上轉場效果
        .transition(.opacity.animation(.linear(duration: 0.4)))

    }
}

```

這個程式碼範例展示了如何使用 `.transition()` 調整器來設定轉場動畫，並使用 `.transformEffect()` 來強制進行變形動畫，以及如何使用條件運算子來避免轉場動畫。

**`withAnimation` Function**

-   `withAnimation` 可以明確地控制動畫的時機，將需要動畫的程式碼放在 `withAnimation` 的 block 裡面。
-   當一個變化會影響多個地方，或者有多種情況可能會產生改變時，可以使用 `withAnimation` 來更精確地設定動畫。
-   例如：

```swift=
 withAnimation {
     // 要產生動畫的程式碼
    selectedFood = foods.shuffled().first ?? ""
 }

```

**總結 (Summary)**

-   SwiftUI 中的動畫分為 **轉場 (Transition)** 和 **變形 (Transformation)** 兩種。
-   SwiftUI 根據 **View** 的 **身份 (Identity)** 來決定使用哪種動畫。
-   **View** 的身份由 **結構位置 (Hierarchy)** 和 **ID** 決定。
-   **轉場動畫** 用於 **View** 的替換，預設為淡入淡出。
-   **變形動畫** 用於 **View** 屬性的改變，例如位置、大小等。
-   可以使用 `.transition()` 調整器來客製化轉場動畫。
-   可以使用 `.transformEffect()` 調整器來強制進行變形動畫。
-   使用 `withAnimation` 可以更精確地控制動畫時機。
-   理解 **View** 的身份和結構位置，以及轉場和變形的區別，是掌握 SwiftUI 動畫的關鍵.

## someView、排版規則、設計細節


**`some View`：不透明類型 (Opaque Type)**

-   **`some` 關鍵字**：在 SwiftUI 中，**`some`** 關鍵字表示一個不透明的類型 (opaque type)。這意味著它代表一個具體的類型，但這個具體的類型是被隱藏的。
-   **具體類型 (Concrete Type)**：雖然 **`some View`** 看起來像是個抽象的類型，但實際上它背後對應的是一個唯一的具體類型。
-   **不透明類型的好處**：
    -   **簡化程式碼**：開發者不需要寫出複雜的、冗長的類型宣告，例如 `ModifiedContent<ModifiedContent<Text, _PaddingLayout>, _EnvironmentKeyWritingModifier<Optional<Color>>>`，只需要使用 **`some View`** 即可。
    -   **效能優化**：SwiftUI 需要具體的類型資訊來優化效能，而 **`some View`** 讓 Swift 在編譯時 (compile time) 可以檢查並知道確切的類型，以便進行最佳化。
-   **類型檢查**：
    -   Swift 會在編譯時檢查 **`some View`** 的具體類型是否一致。
    -   如果 **`some View`** 返回的類型不一致，編譯器會報錯。
-   **範例**：
    
    ```swift=
    // 錯誤範例：some View 返回的類型不一致
    func myView(useDarkMode: Bool) -> some View {
        if useDarkMode {
            return Color.black // Color 類型
        } else {
            return Text("Not Support Dark Mode") // Text 類型
        }
    }
    
    // 正確範例：使用 any View 可以返回不同的類型，但不能用在 View 的 body 裡面
    func myView(useDarkMode: Bool) -> any View {
        if useDarkMode {
            return Color.black
        } else {
            return Text("Not Support Dark Mode")
        }
    }
    
    // 正確範例：確保只返回一種 Color 類型
    func myView(useDarkMode: Bool) -> some View {
        return useDarkMode ? Color.black : Color.white
    }
    
    // 正確範例：返回一個加上 padding 的 Text，類型是 ModifiedContent<Text, _PaddingLayout>，但回傳值仍然是 some View
    func myText() -> some View {
        let text = Text("Hello")
        let text2 = text.padding()
        return text2
    }
    
    ```
    

**調整器 (Modifier)**

-   **調整器的本質**：調整器 (modifier) 實際上是 **View** 的擴展 (extension)，它們會返回一個新的、修改過的 **View**。
-   **類型包裝**：每次使用調整器，都會將原本的 **View** 包裝成一個新的 **View** 類型，例如 `ModifiedContent`。
-   **調整器的順序**：調整器的順序很重要，因為它們會一層層地包裝 **View**，每一層的調整都會影響最終的顯示效果。
-   **通用調整器 (General Modifiers)**：大部分的調整器都是通用的，可以應用於任何 **View**，例如 `animation`、`font`、`frame`、`padding`。
-   **特定調整器 (Specific Modifiers)**：少數調整器是綁定在特定的 **View** 上的，例如 `resizable` 只能用於 `Image`。
-   **範例**：
    
    ```swift=
    // 調整器順序的影響
    VStack {
        Text("Hello")
            .padding()      // 先加上 padding
            .frame(width: 200, height: 100) // 再加上 frame
            .background(Color.yellow)   // 最後加上背景
        Text("Hello")
            .frame(width: 200, height: 100) // 先加上 frame
            .padding()      // 再加上 padding
            .background(Color.yellow)   // 最後加上背景
    }
    
    ```
    
    在這個範例中，第一個 `Text` 先加上 `padding`，然後再加 `frame`，最後加上背景，所以黃色背景會填滿 `frame` 設定的範圍。第二個 `Text` 先加 `frame`，再加 `padding`，所以背景只會填滿文字外框加上 `padding` 的範圍。
-   **改變對應的 View 與影響全部的 View 的調整器 (Modifiers that Change the Corresponding View vs. Modifiers that Affect All Views)**: 有些調整器只會改變對應的 View，有些則會一次影響裡面全部的 View。
    -   影響全部 View 的調整器有些會把相同的調整相加起來，有些則只會套用最先使用的。

**View 的排版 (Layout)**

-   **排版的三個步驟**：SwiftUI 的排版過程分為三個步驟：
    1.  **上層畫面詢問 (Parent Asks)**：上層的 **View** 會詢問下層的 **View** 需要多少空間，同時也會告知下層 **View** 自己有多少可用空間。
    2.  **下層畫面回應 (Child Responds)**：下層的 **View** 必須回應自己需要的大小，而且可以無視上層的可用空間。
    3.  **上層畫面配置 (Parent Arranges)**：上層的 **View** 根據下層 **View** 回應的大小，來決定它們的位置。
-   **大小決定權**：**View** 的大小是由子 **View** 自己決定的，而上層 **View** 只負責決定子 **View** 的位置。
-   **`VStack` 的參數**：`VStack` 的 `alignment` 和 `spacing` 參數，是用於在擺放子 **View** 時使用的。
-   **三種 View 的大小判斷類型 (Three Types of View Size Determination)**:
    -   **`Hugging`**：**View** 非常清楚自己需要的大小，例如 `Text`。
    -   **`Neutral`**：**View** 對自己大小沒有看法，會配合相關的 **View** 來決定，例如 `VStack` 和 `Button`。
    -   **`Expanding`**：**View** 會盡可能地佔用上層給予的空間，例如 `Color` 和加上 `resizable` 的 `Image`。
    -   **X軸與 Y軸**: 每個 View 的 x 軸與 y 軸都有可能是對應其中一種。
-   **範例**：
    -   `Text` 是 `hugging` 的，會根據文字內容決定大小。
    -   `VStack` 是 `neutral` 的，會根據子 `View` 的大小來決定自身的大小。
    -   `Color` 是 `expanding` 的，會盡可能地佔滿上層給予的空間。
    -   `Toggle` 的 x 軸是 `expanding` 會佔滿橫向空間，y 軸是 `neutral` 會根據文字內容決定高度。

**字體大小 (Font Size)**

-   **動態字級 (Dynamic Type)**：使用系統提供的字體，例如 `.title`、`.body` 等，可以讓字體大小根據使用者的系統設定自動調整。
-   **系統字體 (System Font)**: 使用 `.system` 代表使用系統的字體，可以自行決定大小，但不會隨使用者的設定而調整。
-   **固定大小的字體**：如果使用 `.system(size:)` 來設定固定大小的字體，字體大小不會隨著動態字級調整。
-   **`ScaledMetric` propertyWrapper**：可以使用 `ScaledMetric` 來讓數字配合動態字級縮放。
-   **內建字體大小 (Built-in Font Sizes)**: 建議盡量使用內建的字體大小，例如 `largeTitle`、`headline`、`body`、`caption2` 等，以確保最佳的使用者體驗。
-   **Human Interface Guidelines**: 可以參考 Apple 提供的 Human Interface Guidelines 文件，了解更多關於設計人性化介面的資訊。

**圖片資源 (Image Assets)**

-   **縮放因子 (Scale Factor)**：在 **Assets** 中，圖片資源有 1x、2x、3x 的選項，分別對應不同的螢幕解析度。
    -   1x 代表標準解析度螢幕.
    -   2x 代表 Retina 螢幕.
    -   3x 代表超 Retina 螢幕.
-   **圖片選擇**：系統會根據螢幕的縮放因子來選擇使用哪張圖片。
-   **建議**：如果只能提供一張圖片，建議放在 2x 的位置。
-   **螢幕尺寸和縮放因子**：可以在網站上查看不同裝置的螢幕尺寸和縮放因子。

**開發注意事項**

-   **細節考量**：在開發時，需要考慮到字體大小、圖片資源、深淺色模式、輔助模式等細節。
-   **循序漸進**：不需要在練習階段就顧好所有細節，可以先專注於核心功能，再逐步加入其他考量。

**總結 (Summary)**

-   **`some View`** 是一種不透明類型，它隱藏了具體的類型細節，簡化了程式碼並提升了效能。
-   調整器會包裝 **View** 並返回新的 **View**，順序會影響最終的顯示效果。
-   SwiftUI 的排版分為三個步驟，子 **View** 決定大小，上層 **View** 決定位置。
-   字體大小應該使用內建的動態字級，以配合使用者的系統設定。
-   圖片資源需要提供不同縮放因子的版本，以適應不同的螢幕解析度。


## 排版練習


**`@State` 與 `Property Wrapper`**

-   **`@State` 的作用**： **`@State`** 是一個 **Property Wrapper**，用於在 SwiftUI 中管理 **View** 的狀態 (state)。當 **`@State`** 修飾的變數值發生變化時，SwiftUI 會自動更新畫面。
-   **`Property Wrapper` 的概念**: **`Property Wrapper`** 是一種 Swift 的功能，可以讓你將屬性 (property) 的存取邏輯封裝起來，例如 **`@State`** 就是將狀態管理的邏輯封裝起來。
-   **底線版本的屬性 (Underlying Property)**：
    -   當你使用 **`@State`** 修飾一個變數時，SwiftUI 會在背後建立一個新的屬性，這個屬性的名稱是在原本的變數名稱前面加上底線。
    -   這個底線版本的屬性 (underlying property) 才是真正儲存資料的地方。
    -   例如，當你宣告 `@State var selectedFood: Food?` 時，實際儲存數值的地方是 `_selectedFood`。
-   **初始化 (Initialization)**：
    -   你可以使用 `.init` 來初始化底線版本的屬性，並設定初始值。
    -   例如，`_selectedFood = State(initialValue: .examples)` 可以將 `selectedFood` 的初始值設為預設食物列表中的第一個。
-   **自訂啟動 (Custom Launch)**：
    -   你可以透過 **extension** 來新增 **View** 的啟動方式，而不會覆蓋預設的啟動方式。
    -   例如，在 **`ContentView`** 的 **extension** 中，新增一個有預設食物的啟動方式，只影響 **preview**。
-   **範例**：

```swift=
    // 在 ContentView 中宣告 @State 變數
    struct ContentView: View {
        @State private var selectedFood: Food?
    }

    // 使用 extension 新增預設食物的啟動方式
    extension ContentView {
        static var previewWithFood: ContentView {
            var view = ContentView()
            view._selectedFood = State(initialValue: .examples)
            return view
        }
    }

```

-   **使用 Property Wrapper**: 如果你想要直接存取 **`Property Wrapper`** 包裝的值，你必須在變數前面加上底線，並使用 **`wrappedValue`** 來存取。例如：`_selectedFood.wrappedValue`。

**排版 (Layout) 相關的 View 與調整器 (Modifier)**

-   **`HStack`**：
    -   **水平排列 (Horizontal Alignment)**： `HStack` 會將子 **View** 水平排列。
    -   **與 `Text` 的對齊**：當 `HStack` 裡面有文字和 **SFSymbol** 時，預設是垂直對齊。
-   **`VStack`**：
    -   **垂直排列 (Vertical Alignment)**： `VStack` 會將子 **View** 垂直排列。
    -   **換行符號 (Line Break)**：在 `Text` 中使用換行符號 `\n` 可以強制換行。
-   **`Text`**：
    -   **文字顯示 (Text Display)**：用於顯示文字內容。
    -   **字體設定 (Font Settings)**：可以設定字體大小和字重 (font weight)。
    -   **字串插補 (String Interpolation)**： 可以使用字串插補將 **SFSymbol** 放入 `Text` 中顯示。
    -   **`.formatted`**: 可以將數字類型轉為字串顯示，例如：`Double`。
    -   **最小縮放比例 (minimumScaleFactor)**: 當文字內容過長時，可以設定最小縮放比例，讓文字自動縮小以適應空間。
    -   **行數限制 (lineLimit)**: 可以設定文字顯示的最大行數。
-   **`SFSymbol`**：
    -   **系統圖示 (System Icons)**： Apple 提供的系統圖示，可以當作字體來使用。
    -   **字體調整**：可以像文字一樣調整大小和字重。
-   **`Divider`**：
    -   **分隔線 (Separator)**：用於在 **View** 之間繪製分隔線。
    -   **方向 (Orientation)**：分隔線的方向會根據其所在的 **Stack** 方向而變化。
        -   在 `VStack` 中是水平線。
        -   在 `HStack` 中是垂直線。
        -   如果不在任何 Stack 內，則為水平線。
    -   **寬度 (Width)**：當空間不足時，分隔線的寬度會縮小到 0，需要使用 `frame` 強制設定寬度。
-   **`frame`**：
    -   **尺寸設定 (Size Setting)**： 可以設定 **View** 的寬度 (width) 和高度 (height)。
    -   **強制設定 (Forced Setting)**： 可以強制設定 **View** 的大小，避免因空間不足而消失。
-   **`padding`**：
    -   **邊距設定 (Margin Setting)**： 可以設定 **View** 的邊距。
    -   **邊距方向 (Padding Direction)**： 可以指定邊距的方向，例如水平 (horizontal) 或垂直 (vertical)。
-   **`background`**：
    -   **背景設定 (Background Setting)**： 可以為 **View** 設定背景顏色或形狀。
    -   **順序 (Order)**： `padding` 要加在 `background` 之前，才能讓背景也跟著變大。
-   **`ScrollView`**:
    -   **可滾動畫面 (Scrollable View)**: 提供可滾動的畫面，預設是垂直滾動，可以透過參數改為水平滾動。
    -   **高度 (Height)**: 在 **ScrollView** 中，子 **View** 可以佔用任意高度，因為 **ScrollView** 本身可以滾動。
    -   **expanding 與 neutral**: **ScrollView** 的滾動方向是 `expanding`，非滾動方向則是 `neutral`。
-   **`Spacer`**:
    -   **佔位 View (Placeholder View)**: 用於佔據空間的 **View**。
    -   **彈性 (Flexibility)**: 在 **Stack** 中，`Spacer` 會嘗試佔滿 **Stack** 的主要方向。
    -   **無方向限制**: 在沒有定義方向的 View 中，會佔滿所有空間。
-   **`Group`**:
    -   **群組 (Grouping)**: 將多個 **View** 包裝在一起，可以對群組中的 **View** 套用相同的調整器。
    -   **功能性 View (Functional View)**: 本身不顯示任何內容，僅提供功能。
-   **`Button`**:
    -   **按鈕 (Button)**: 用於觸發動作的按鈕。
    -   **按鈕風格 (ButtonStyle)**: 可以設定按鈕的風格，例如 `plain` 表示不使用任何風格調整。
-   **`cliped`**:
    -   **剪裁 (Clipping)**: 將 **View** 的內容剪裁到 **View** 的邊界內。
-   **`layoutPriority`**:
    -   **排版優先度 (Layout Priority)**: 設定 **View** 的排版優先度，數值越大，優先度越高。
    -   **預設值**: 預設每個 **View** 的優先度都是 0。

**`Grid` 與格狀排版 (Grid Layout)**

-   **`Grid`**：
    -   **格狀排版 (Grid Layout)**：用於建立格狀排版的 **View**，適用於像表格或 Instagram 那樣的排版。
    -   **`GridRow`**: 在 **`Grid`** 裡面使用 `GridRow` 來建立橫向的一排。
    -   **間距 (Spacing)**: 可以設定格狀排版中水平和垂直的間距。
    -   **`.gridCellUnsizedAxes`**: 可以避免 **Grid** 給子畫面額外的空間，使其不會撐滿畫面。
    -   **與 `Group` 類似**: `GridRow` 具有與 `Group` 類似的特性，可以將調整器賦予給其所有的子 **View**。
-   **`GridRow`**:
    -   **代表橫向的一排**: 在 `Grid` 中代表橫向的一排。
    -   **調整器會賦予給子 View**: 當給一個 `row` 調整器時，它會把這個調整器賦予給它所有的 **cells**。

**動畫 (Animation)**

-   **`transition`**:
    -   **轉場動畫 (Transition Animation)**：可以設定 **View** 出現或消失時的動畫效果。
    -   **效果 (Effects)**：例如，可以設定從上方滑入的動畫效果，並結合透明度變化。
-   **`animation`**：
    -   **動畫曲線 (Animation Curve)**： 可以設定動畫的曲線，例如 `spring` 可以產生彈跳效果。
    -   **`dampingFraction`**: `spring` 動畫的參數之一，數值介於 0 到 1 之間，越低彈性越大。

**開發流程與觀念**

-   **由內而外 (Inside-Out)**：
    -   先從內容 (content) 開始，再考慮外觀 (appearance)。
    -   當畫面顯示不如預期時，先思考原因，而不是直接使用調整器來硬改。
-   **妥協 (Compromise)**：
    -   如果 SwiftUI 沒有提供你想要的排版方式，可以考慮妥協，或者使用其他更適合的 **View** 或調整器。
    -   如果真的無法妥協，可以考慮使用 UIKit 來實作。
-   **命令式 (Imperative) vs. 宣告式 (Declarative) 的寫法**:
    -   SwiftUI 是宣告式 (declarative) 的，你只需要描述你想要的畫面，而不需要詳細指定每一步要怎麼做。
    -   命令式 (imperative) 的寫法則是需要你詳細控制每一個步驟。
    -   當你發現自己在做很多重複的事情，或是需要詳細控制每一個步驟時，就要停下來思考是否有更適合的作法。
-   **排版優先度 (Layout Priority)**：
    -   `hugging` 和 `neutral` 的 **View** 的優先度會比 `expanding` 的 **View** 高。
    -   當有多個 **View** 都想佔用剩餘空間時，優先度較高的會先拿到。
-   **避免過度調整 (Avoid Over-Adjusting)**：
    -   避免使用過多的 `frame` 或 `offset` 等調整器來硬改排版。
    -   多花時間理解 SwiftUI 的排版規則，可以減少不必要的調整。

## 程式碼重構


**程式碼重構 (Refactor) 的目的**

-   **提高程式碼可讀性 (Readability)**：讓程式碼看起來更清晰、更容易理解。
-   **提高程式碼可維護性 (Maintainability)**：使程式碼更容易修改和擴充。
-   **提高程式碼重複使用性 (Reusability)**：將常用的程式碼片段提取出來，方便在其他地方重複使用。
-   **簡化程式碼 (Simplify Code)**：讓程式碼更簡潔，減少不必要的複雜性。

**程式碼重構的主要步驟**

1.  **屬性宣告 (Property Declaration)**
    -   **`Property Wrapper` 的排序**：將使用 **`Property Wrapper`** 修飾的屬性放在前面。
    -   **相關屬性歸類**：將相關的屬性放在一起。
    -   **布林值命名 (Boolean Naming)**：**布林值** 的命名應該使用是否的問句，例如將 `showInfo` 改名為 `shouldShowInfo`。
2.  **提取子 **View** (Extract Subviews)**
    
    -   **將複雜的 body 內容分解**：將 **`body`** 中過長的程式碼分解成小的、可重用的 **子 View (Subviews)**。
    -   **計算屬性 (Computed Properties)**：使用 **計算屬性** 來儲存這些子 **View**，並將其命名為具有描述性的名稱，例如 `foodImage`、`selectedFoodInfo`。
        -   **`some View`**: 計算屬性的類型可以設定為 `some View`。
    -   **避免使用 info 結尾**：為避免誤解，不要只用 `info` 作為子 **View** 的結尾，可以加上 `view`，例如 `selectedFoodInfoView`，以清楚表示這是一個畫面。
    -   **使用 `@ViewBuilder`**：當你的 **closure (閉包)** 中包含多個 **View** 時，你必須在參數前面加上 `@ViewBuilder`，讓 Swift 可以正確地組合成一個 **View**。
    
    ```swift=
        // 範例：使用 @ViewBuilder 的計算屬性
        @ViewBuilder
        var selectedFoodInfoView: some View {
            if let food = selectedFood {
                VStack {
                    Text(food.name)
                    Text("\(food.calories) 大卡")
                }
            }
        }
    
    ```
    
3.  **調整器 (Modifier) 的重構**
    
    -   **提取常用的調整器**：將常用的調整器打包成一個新的調整器，例如將 `buttonStyle`、`buttonBorderShape` 和 `controlSize` 打包成 `.mainButtonStyle()`。
    -   **擴充 `View` (View Extension)**：在 `View` 的 **extension** 中建立這些新的調整器，使它們可以在任何 **View** 上使用。
        -   **`self`**: 在 **View** 的 **extension** 中，`self` 代表呼叫這個方法的 **View**。
        -   **`some View`**: 調整器需要回傳一個 `some View`.
    
    ```swift=
        // 範例：建立自訂的按鈕風格調整器
        extension View {
            func mainButtonStyle() -> some View {
                self
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle)
                    .controlSize(.large)
            }
        }
    
        // 使用方式
        Button("按鈕") {
            // 按鈕動作
        }
        .mainButtonStyle()
    
    ```
    
    -   **不要寫 `self`**: 雖然不寫 `self` 有一點不直覺，但建議不要寫 `self`，以避免在 **Reference Type** 中不小心 capture 到不該 capture 的東西。
4.  **動畫曲線 (Animation Curve) 的重構**
    
    -   **提取動畫曲線**：將常用的動畫曲線提取出來，例如 `spring` 動畫。
    -   **靜態屬性 (Static Properties)**：將動畫曲線儲存在 `Animation` 的 **靜態屬性** 中，因為它們不依賴於實例本身，而是類型本身。
    
    ```swift=
       // 範例：在 Animation extension 中建立靜態動畫屬性
        extension Animation {
           static let mySpring = Animation.spring(dampingFraction: 0.5)
           static let myEase = Animation.easeIn(duration: 0.2)
        }
    
       // 使用方式
       .animation(.mySpring, value: shouldShowInfo)
    
    ```
    
    -   **命名**: 可以使用 `my` 作為前綴，或者使用專案名稱縮寫，以便區分內建的屬性。
5.  **顏色 (Color) 的重構**
    
    -   **提取常用顏色**：將常用的顏色提取出來，例如背景色。
    -   **靜態屬性 (Static Properties)**：將顏色儲存在 `Color` 的 **靜態屬性** 中。
    
    ```swift=
        // 範例：在 Color extension 中建立靜態顏色屬性
        extension Color {
            static let bg2 = Color(red: 0.9, green: 0.9, blue: 0.9)
        }
    
        // 使用方式
        .background(Color.bg2)
    
    ```
    
    -   **注意 `ShapeStyle`**: **background** 調整器接收的參數是一個符合 **`ShapeStyle`** 的類型，而不是直接接收 `Color`。你需要完整寫出這個類型，例如 `Color.bg2`。
6.  **轉場 (Transition) 的重構**
    
    -   **提取轉場效果**: 將常用的轉場效果提取出來，例如 `opacity` 加上 `delay` 的效果.
    -   **靜態屬性 (Static Properties)**: 將轉場效果儲存在 `AnyTransition` 的 **靜態屬性** 中.
    
    ```swift=
        // 範例：在 AnyTransition extension 中建立靜態轉場屬性
        extension AnyTransition {
            static let delayInsertionOpacity = AnyTransition.opacity.animation(.linear(duration: 0.2))
            static let moveUpWithOpacity = AnyTransition.move(edge: .top).combined(with: .opacity)
        }
    
        // 使用方式
        .transition(.delayInsertionOpacity)
    
    ```
    
    -   **使用 `Self`**: 可以使用 `Self` 來代替 `AnyTransition`，讓程式碼更簡潔。
7.  **背景 (Background) 的重構**
    
    -   **提取常用背景樣式**：將常用的背景樣式提取出來，例如圓角矩形背景。
    -   **可配置的參數 (Configurable Parameters)**：將背景的參數提取出來，例如圓角半徑和顏色，使之更具彈性。
    -   **使用 `ShapeStyle`**: 背景的填色可以使用 `.fill` 搭配 `ShapeStyle`，而不是直接使用 `Color`，這樣可以接受更多不同的類型。
    -   **`some ShapeStyle`**: 可以使用 `some ShapeStyle` 來簡化程式碼，不需要再宣告一個 **Generic** 類型。
    
    ```swift=
        // 範例：在 View extension 中建立圓角矩形背景調整器
        extension View {
             func roundedRectBackground(radius: CGFloat = 8, fill: some ShapeStyle = Color.gray) -> some View {
                 self
                     .background(
                         RoundedRectangle(cornerRadius: radius)
                             .fill(fill)
                     )
            }
        }
    
        // 使用方式
        .roundedRectBackground(radius: 10, fill: .blue)
    
    ```
    
8.  **文字 (Text) 的重構**
    
    -   **避免在 View 中處理資料**：盡量不要在 **View** 中進行資料格式化的工作。
    -   **在資料模型 (Model) 中格式化資料**：將資料格式化的工作移到資料模型中，讓 **View** 專注於顯示。
    -   **使用 `Property Wrapper`**：當需要對多個屬性進行相同的格式化時，可以使用 **`Property Wrapper`** 來封裝格式化的邏輯，避免重複程式碼。
    -   **`@propertyWrapper`**: 使用 `@propertyWrapper` 宣告 **`Property Wrapper`**。
    -   **`wrappedValue`**: 用來存取 **`Property Wrapper`** 包裝的值。
    -   **`projectedValue`**: 用來存取 **`Property Wrapper`** 提供的額外功能，例如加上後綴的字串。
    -   **`Equatable`**: 如果你的 **`Property Wrapper`** 內有不是 `Equatable` 的值，需要讓 **`Property Wrapper`** 也遵守 `Equatable`。
    
    ```swift=
        // 範例：建立一個 Suffix Property Wrapper
        @propertyWrapper
        struct Suffix {
             var wrappedValue: Double = .zero
             let suffix: String
    
             init(wrappedValue: Double = .zero, suffix: String) {
                 self.wrappedValue = wrappedValue
                 self.suffix = suffix
             }
    
             var projectedValue: String {
                 return "\(wrappedValue.formatted)\(suffix)"
             }
        }
    
        // 在資料模型中使用
        struct Food {
            @Suffix(suffix: "g") var protein: Double
            @Suffix(suffix: "大卡") var calories: Double
        }
    
        // 在 ContentView 中使用
        Text($food.protein) // 顯示格式化後的蛋白質
        Text($food.calories) // 顯示格式化後的卡路里
    
    ```
    
    -   **預設值 (Default value)**: 在 **`Property Wrapper`** 中，需要給一個預設值，以便在初始化時使用。在 `Double` 的情況下，給一個 `.zero` 作為預設值。
9.  **檔案結構 (File Structure)**
    -   **將 `extension` 放在單獨的檔案中**：將 **`extension`** 放在單獨的檔案中，以便更好地管理程式碼，並提高程式碼的可讀性。
    -   **使用 `Mark`**：在程式碼中使用 `Mark` 來標記程式碼的區塊，方便在導覽列中快速找到程式碼。
    -   **`private`**: 將子 **View** 設定為 `private`，避免外部直接存取，這些子 **View** 僅用於組成 `ContentView`。

**開發流程與觀念**

-   **先求有，再求好**：先完成功能，再進行重構。
-   **重構沒有硬性規則**：重構的方式沒有絕對的對錯，只要能提高程式碼的可讀性和可維護性即可。
-   **不要過度重構**：不要為了重構而重構，只有當程式碼需要重複使用或變得複雜時，才需要進行重構。
-   **View 應該只關注畫面呈現**: View 的責任是呈現畫面，而不是處理資料邏輯，應該將資料處理的邏輯放到 Model 或其他地方.
-   **了解 `ViewBuilder`**: 了解 `ViewBuilder` 如何將不同的東西組合在一起，以及什麼時候需要使用 `@ViewBuilder`，可以幫助你寫出更簡潔的 SwiftUI 程式碼.

## ShapeStyle、圖層、ViewBuilder

**ShapeStyle**

-   **定義：** **ShapeStyle** 代表用於渲染形狀的顏色或樣式。它是一個 **protocol**，定義了如何填充形狀的樣式。
-   **不要自行創建 ShapeStyle 類型：** 應使用 SwiftUI 提供的顏色 (**Color**)、圖片 (**Image**) 或漸層 (**Gradient**) 來填充形狀，而非自己創建。
-   **`.fill` 調整器 (Modifier)：** **`.fill`** 是一個形狀專用的調整器，它接收一個 **ShapeStyle** 作為參數，用於填充形狀。
-   **顏色 (Color) 的使用：** 可以直接在 **`.fill`** 中使用顏色，例如：`.fill(.cyan)`。
-   **漸層 (Gradient) 的使用：** 可以使用 **`.gradient`** 取得顏色的漸層版本，例如：`.cyan.gradient`。也可以使用不同的漸層類型，如線性漸層 (**linearGradient**)、放射狀漸層 (**radialGradient**)、橢圓形漸層 (**ellipticalGradient**)，例如：`.linearGradient(colors: [.pink, .indigo], startPoint: .topLeading, endPoint: .bottomTrailing)`。
-   **圖片 (Image) 的使用：** 可以使用 **`.image`** 將圖片作為填充樣式，並使用 **`.scaleEffect`** 調整圖片大小，例如：`.fill(.image(Image("盤子")).scaleEffect(0.2))`。
-   **`foregroundStyle` 調整器 (Modifier)：** **`foregroundStyle`** 也可以接收 **ShapeStyle**，但它不限於形狀使用，可以用於任何 **View**，例如文字。
    -   **效能考量：** 如果只是要對形狀填色，使用 **`.fill`** 的效能會比 **`foregroundStyle`** 好，因為 **`foregroundStyle`** 背後還是建立在形狀的 **`.fill`** 上，只是多做了一些剪裁調整。
-   **擴充 (Extension) Color 的使用：** 可以透過 **`extension`** 擴充 **Color**，使其可以像 SwiftUI 內建的顏色一樣直接使用，例如：
    
    ```swift=
    extension ShapeStyle where Self == Color {
        static var bg2: Color {
            Color(red: 0.9, green: 0.9, blue: 0.9)
        }
    }
    
    ```
    
    -   **`Self` 的使用：** 在 **`extension`** 中，**`Self`** 代表擴充的類型，在此例中是 **Color**。
    -   **計算屬性 (Computed Properties)：** 在 **protocol extension** 中不能使用靜態儲存屬性 (static stored properties)，要使用計算屬性 (computed properties)。

**圖層 (Layers)**

-   **圖層的概念：** 畫面除了 X 軸和 Y 軸，還有 Z 軸，代表圖層的前後順序。
-   **`background` 調整器 (Modifier)：** **`background`** 會在現有畫面的後面新增一層畫面，可以添加多個背景。
-   **`overlay` 調整器 (Modifier)：** **`overlay`** 會在現有畫面的前面新增一層畫面。
-   **ZStack：** **ZStack** 是一個在 Z 軸上進行排版的 **View**，可以將多個 **View** 疊加在一起，形成圖層效果。
-   **陰影 (Shadow)：** **陰影** 是在畫面後方新增一層效果，也可以疊加多層陰影。
-   **調整大小：**
    -   **`padding` 調整器 (Modifier)：** 可以使用 **`padding`** 調整畫面大小。
    -   **`scaleEffect` 調整器 (Modifier)：** 可以使用 **`scaleEffect`** 調整背景的大小，可以設定 X 軸和 Y 軸不同的縮放比例。
-   **模糊效果 (Blur)：** 可以使用 **`blur`** 調整器 (modifier) 來模糊背景，產生柔邊效果。
-   **Z-Position：** SwiftUI 會自動計算每個 **View** 在 Z 軸上的位置，稱為 **Z-Position**。
-   **zIndex 調整器 (Modifier)：** 可以使用 **`zIndex`** 調整器來影響 **View** 的圖層順序，**zIndex** 值較大的 **View** 會顯示在上方。沒有設定 **zIndex** 的 **View**，其預設 **zIndex** 值為 0。
-   **動畫 (Animation) 的影響：**
    -   **Z-Position 的變化：** 當 **ZStack** 內的 **View** 新增或移除時，**Z-Position** 會發生變化，但這個變化無法產生動畫效果。
    -   **解決方法：**
        -   **設定 zIndex：** 將 **ZStack** 內的所有 **View** 的 **zIndex** 設定為非 0 的值，可以解決部分動畫問題。
        -   **避免在 ZStack 中新增或移除 View：** 盡量不要在 **ZStack** 中使用 `if` 條件來顯示或隱藏 **View**，而是改用調整透明度 (**opacity**) 的方式來達到相同的效果。
        -   **使用 `opacity`：** 使用 **`opacity`** 來控制 **View** 的顯示和隱藏，並搭配動畫效果，例如：`.opacity(shouldShow ? 1 : 0)`。

**ViewBuilder**

-   **定義：** **ViewBuilder** 是一個 **resultBuilder**，用於將多個 **View** 組合成一個 **View**。
-   **限制：** 使用 **ViewBuilder** 的 **View**，最多只能放入 10 個子 **View**。
-   **TupleView：** **ViewBuilder** 會將子 **View** 組合成 **TupleView**，**TupleView** 的 **Generic** 參數會隨著子 **View** 的數量增加。
-   **解決方法：** 如果需要放入超過 10 個子 **View**，可以使用 **Group** 來將子 **View** 打包。
-   **Group：** **Group** 是一個不會影響排版的 **View**，可以用於將多個 **View** 打包，但 **Group** 本身也受到 **ViewBuilder** 的限制，最多只能放入 10 個子 **View**。
-   **eager view：** 像是 **VStack** 或 **Grid** 這些排版用的 **View**，會直接把所有的子畫面都顯示出來，無論是否需要用到。
-   **lazy view：** 如果需要顯示大量畫面，可以使用對應的 **lazy** 版本，例如 **LazyVGrid**、**LazyHGrid**、**LazyHStack**、**LazyVStack**。這些 **lazy view** 會在使用者滑動到需要顯示的畫面時才進行渲染，可以提高效能。
    -   **排版差異：** **lazy view** 的排版結果可能與 **eager view** 不同，因為 **lazy view** 不會預先知道子 **View** 的總大小。

**其他重點**

-   **leading 和 trailing：** **leading** 和 **trailing** 代表文字的開始方向和結束方向，而不是單純的左邊和右邊，在不同語系 (例如阿拉伯語) 中會有不同的表現。
-   **fixedSize 調整器 (Modifier)：** **`fixedSize`** 可以強制 **View** 使用其理想的大小，可以設定 X 軸和 Y 軸是否使用理想大小。
    -   **安全區域 (Safe Area)：** 使用 **`fixedSize`** 時要注意，可能會使 **View** 超出安全區域，造成無法點擊的問題。建議將使用 **`fixedSize`** 的 **View** 放在 **ScrollView** 裡面。
-   **多行文字調整：** 可以使用 **`multilineTextAlignment`** 調整多行文字的對齊方式，使用 **`lineSpacing`** 調整行距。

## 建立動態畫面：ForEach、List


**ForEach**

-   **用途：** **ForEach** 是一個 **View**，用於根據 **ID (Identifier)** 動態產生畫面。它會根據資料集合的內容變化，自動更新畫面。
-   **與 loop 迴圈的區別：** **loop 迴圈 (loop)** 是一種流程控制，本身不保證任何輸出。**ForEach** 則是一個專門產生畫面的 **View**。
-   **ID 的重要性：** 使用 **ForEach** 時，必須為每一筆資料設定 **ID**，作為 **View** 的身分 **ID**。當資料變動時，SwiftUI 會根據 **ID** 的變化來更新畫面，並可能產生動畫效果。
-   **效能考量：** **ForEach** 會透過 **ID** 重複使用已存在的 **View**，提升效能。
-   **Generic 類型：** **ForEach** 需要三個 **Generic** 類型：
    -   **Data:** 要迭代的資料集合，必須符合 **RandomAccessCollection** 協定，確保每一筆資料都能快速取得。
    -   **ID:** 用於判斷是否為同一個 **View** 的資料，必須是 **Hashable** 的。
    -   **Content:** 根據每一筆資料產生出來的畫面。
-   **建立 ForEach 的方式：** 主要有兩種方式：
    
    1.  **使用 Identifiable 的 Collection:**
        
        -   如果資料集合中的元素 (Element) 已經符合 **Identifiable** 協定，可以直接將資料集合放入 **ForEach** 中，並提供一個根據元素產生 **View** 的 **closure**。
        -   **Identifiable** 協定會設定一個 **id** 屬性，作為畫面的 **ID**。
        -   例如，可以宣告一個符合 **Identifiable** 的狗狗類型，並將名字設定為 **id**：
        
        ```swift=
        struct Dog: Identifiable {
            let id = UUID()  // 使用 UUID 確保唯一性
            let name: String
            let age: Int
        }
        
        ```
        
        -   然後建立一個狗狗的 **array**，並在 **View** 中使用 **ForEach** 來產生畫面：
        
        ```swift=
        let dogs = [
            Dog(name: "小黑", age: 3),
            Dog(name: "小白", age: 5),
            Dog(name: "小黃", age: 2)
        ]
        
        ForEach(dogs) { dog in
            Text("\(dog.name) is \(dog.age) years old.")
        }
        
        ```
        
    2.  **提供 ID 的 KeyPath:**
        
        -   如果資料集合中的元素 (Element) 沒有符合 **Identifiable** 協定，可以透過 **id** 參數提供一個 **KeyPath**，指定用哪個屬性作為 **ID**。
        -   例如，可以使用狗狗的名字作為 **ID**：
        
        ```swift=
        struct Dog {
            let name: String
            let age: Int
        }
        
        let dogs = [
            Dog(name: "小黑", age: 3),
            Dog(name: "小白", age: 5),
            Dog(name: "小黃", age: 2)
        ]
        
        ForEach(dogs, id: \.name) { dog in
            Text("\(dog.name) is \(dog.age) years old.")
        }
        
        ```
        
    
    -   **使用 `self` 作為 ID：** 如果資料本身是 **Hashable** 的，可以直接使用 **self** 作為 **ID**。
    -   **使用 index 作為 ID：** 如果確定資料的 **index** 永遠不會變，可以使用 **index** 作為 **ID**。
-   **ID 的唯一性：** 必須確保 **ID** 的唯一性，否則會發生畫面重複使用的問題。例如，如果有多個名字相同的狗狗，SwiftUI 會將它們視為同一隻狗狗。
-   **搭配 `onDelete` 和 `onMove`：** **ForEach** 可以搭配 **`onDelete`** 和 **`onMove`** 調整器 (modifier) 來實現刪除和移動的功能。

**List**

-   **用途：** **List** 是一個可以產生動態或靜態畫面的 **View**，具有自帶的排版功能。
-   **動態畫面：** **List** 可以像 **ForEach** 一樣，根據資料集合動態產生畫面。
-   **靜態畫面：** **List** 可以直接放入固定的內容，例如：

```swift=
        List {
            Text("靜態內容 1")
            Text("靜態內容 2")
        }

```

-   **動靜態混合：** **List** 可以包含 **ForEach**，同時顯示靜態和動態內容。

```swift=
        List {
            Text("我的可愛小狗狗")
            ForEach(dogs) { dog in
                Text("\(dog.name)")
            }
        }

```

-   **排版功能：** **List** 是一個垂直排列、可滾動的畫面。
-   **風格 (Style)：** **List** 提供多種風格：
    -   **plain:** 沒有任何風格。
    -   **grouped:** 使用不同的背景顏色來區分組別。
    -   **insetGrouped:** 預設風格，帶有留白的空間。
    -   **sidebar:** 每一個組別可以展開和關閉。
-   **Section：** 可以使用 **Section** 將 **List** 中的內容分組。
-   **調整器 (Modifier)：**
    -   **風格調整器：** 必須在 **List** 建立之前設定。
    -   **其他調整器：** 必須在 **List** 裡面設定。
    -   **分隔線：** 可以調整分隔線的顏色和樣式。
-   **自帶移動和刪除功能：** **List** 可以搭配 **`editActions`** 參數，讓使用者滑動刪除或長按移動。
-   **使用 Binding：** 要讓 **List** 可以修改資料，需要使用 **Binding** 來指向資料集合。
    -   資料集合必須是 **MutableCollection**。
    -   **Binding** 是一個連接，讓 **List** 知道如何與資料互動。
    -   **State** 的 projected value 就是 **Binding**。
-   **搭配 `selection` 參數：** **List** 可以搭配 **`selection`** 參數，讓使用者選擇清單中的項目。
    -   **`selection`** 參數會將使用者選擇的資料 **id** 更新到提供的 **Set** 中。
    -   可以實現單選或多選。
    -   **編輯模式 (Edit Mode)：** 搭配編輯按鈕可以切換編輯模式，讓使用者多選、刪除或移動。

**Binding**

-   **定義：** **Binding** 是一個連接，用於連接 **View** 和資料。
-   **用途：** **Binding** 可以讓 **View** 修改資料，並確保資料的變化能反映在 **View** 上。
-   **使用時機：** 當 **View** 需要修改資料時，就需要使用 **Binding**。例如：
    -   **List** 的刪除和移動功能。
    -   **List** 的選擇功能。
-   **取得 Binding：** 通常透過 **State** 的 **projected value** ($) 來取得 **Binding**。例如：`@State var dogs: [Dog] = [...]`，使用時會是 `$dogs`。
-   **不是任何 Collection 加上 $ 都會變成 Binding：** 只有當 **Collection** 包裹在 **State** 裡面時，才能使用 **$** 取得 **Binding**。
-   **`MutableCollection`**: 需要使用 **`MutableCollection`** 協定來確保資料可以被修改。

**IndexSet**

-   **定義：** **IndexSet** 是一個有效率的方法來儲存一段連續的 **index** 資訊。
-   **用途：** 用於 **`onDelete`** 和 **`onMove`** 調整器中，表示要刪除或移動的資料的 **index**。
-   **使用方法：** 只要使用內建的 **RandomAccessCollection** 並將資料宣告成可修改的，就可以直接使用 **IndexSet**。

**總結**

-   **ForEach** 用於根據資料動態產生 **View**，需要設定唯一的 **ID**.
-   **List** 用於產生動態或靜態畫面，具有自帶的排版功能，並可搭配多種風格和功能.
-   **Binding** 用於連接 **View** 和資料，讓 **View** 可以修改資料.
-   **IndexSet** 用於儲存 **index** 資訊，搭配 **`onDelete`** 和 **`onMove`** 使用.

## PropertyWrapper 屬性包裝器


**Property Wrapper (屬性包裝)**

-   **用途：** **Property Wrapper** 是一種用於打包計算屬性 (computed properties) 和屬性觀察 (property observation) 功能的機制。它允許將屬性的邏輯封裝起來，並在多個屬性中重複使用，達到程式碼的複用性。
-   **基本概念：** **Property Wrapper** 本質上是一個 **struct**、**class** 或 **enum**，它會包裝一個屬性，並提供額外的功能。
-   **產生的屬性：** 當一個屬性加上 **Property Wrapper** 後，會產生三個相關的屬性：
    -   **原始屬性 (Original Property)：** 就是你原本定義的屬性，例如 `var fat: Double = 0.0`，它會儲存實際的值。
    -   **底線版本屬性 (Underlined Version)：** 名稱是在原始屬性名稱前加上底線 `_`，例如 `_fat`。這個屬性代表 **Property Wrapper** 本身，也就是那個 **struct**、**class** 或 **enum** 的實例。
    -   **錢錢版本屬性 (Projected Value)：** 名稱是在原始屬性名稱前加上錢錢符號 `$`，例如 `$fat`。這個屬性是 **Property Wrapper** 透過 **projectedValue** 提供的額外功能。並非所有 **Property Wrapper** 都有 **projectedValue**。
-   **projectedValue：** **projectedValue** 可以被設定為任何屬性，它讓 **Property Wrapper** 可以將自身的功能暴露給外部使用。當你使用別人寫的 **projectedValue** 時，可能會覺得有點奇怪，但熟悉後會覺得非常方便。

**State (狀態)**

-   **用途：** **State** 主要用於觀察 **Value Type** 數值的變化。
-   **Value Type：** 在 SwiftUI 中，**View** 是一個 **struct**，而畫面是在 **body** 這個計算屬性中產生的。**Value Type** 無法在計算屬性中修改自身的值，因此需要使用 **State** 來管理。
-   **資料管理：** **State** 會將資料儲存在 **View** 之外的地方進行管理，並在數值變化時自動通知畫面更新。
-   **Thread-safe (執行緒安全)：** **State** 具有執行緒安全的存取機制，不用擔心在不同執行緒同時修改的問題。
-   **生命週期：** **State** 的生命週期與建立它的 **View** 相同，確保 **State** 只屬於建立它的那個 **View**。
-   **使用限制：**
    -   **private 屬性：** 必須將 **State** 屬性宣告為 **private**，避免在 **View** 之外的地方啟動它。
    -   **初始化：** 如果需要動態的初始值，應該在 **struct** 的 **init** 裡面啟動底線版本的 **State**。
    -   **避免使用底線版本：** 不應該直接使用 **State** 的底線版本，應該透過 **projectedValue** 來操作。
    -   **不得傳遞：** **State** 不應該以任何形式傳遞到其他地方。
-   **projectedValue：** **State** 的 **projectedValue** 是 **Binding**，它直接連接到 **State** 裡面包裝的數值。

**Binding (綁定)**

-   **用途：** **Binding** 是一個可以被傳來傳去的計算屬性，用於傳遞對 **Value Type** 資料的修改方法。
-   **本質：** **Binding** 內部存儲了兩個 **closure**：一個是 **get** 用於回傳數值，另一個是 **set** 用於設定數值。
-   **與 State 的關係：** **Binding** 通常用於連接 **State** 中儲存的數值，讓不同的 **View** 可以讀取和修改同一個數值。
-   **Value Type：** **Binding** 的 **Value** 可以是任何類型。
-   **運作方式：** **Binding** 本質上是 **Reference Type**，透過 **closure** 來存取和修改資料，因此可以實現多個地方同時修改同一個數值的效果。
-   **Property Wrapper 寫法：** 可以使用 **Property Wrapper** 的方式宣告 **Binding** 屬性，例如 `@Binding var money: Int`，這樣可以不用再使用 `.wrappedValue` 來存取值。
-   **projectedValue：** **Binding** 的 **projectedValue** 就是它自己本身，這代表你可以直接操作 **Binding** 這個 **Property Wrapper**。
-   **使用場景：**
    -   **TextField：** **TextField** 需要 **Binding** 來儲存使用者輸入的值，因為 **TextField** 本身不應該擁有 **State**。
    -   **跨 View 資料傳遞：** 當多個 **View** 需要存取和修改同一個資料時，應該將 **State** 建立在最上層的 **View**，然後透過 **Binding** 將資料傳遞到子 **View**。
-   **畫面更新：** **Binding** 本身不會觸發畫面更新，畫面更新是由 **State** 觸發的。**Binding** 只是幫助不同地方存取同一個 **Value Type** 資料。

**程式碼範例**

```swift=
struct LoginView: View {
    @State private var username = ""
    @State private var password = ""

    var body: some View {
        VStack {
            TextField("Username", text: $username) // 使用 $username 取得 Binding
            TextField("Password", text: $password) // 使用 $password 取得 Binding
            Button("Login") {
                login(username: username, password: password)
            }
        }
    }

    func login(username: String, password: String) {
        // 登入邏輯
    }
}

```

**Environment (環境)**

-   **用途：** **Environment** 可以被視為環境變數，系統會在 App 啟動時自動設定這些變數，例如使用者的顏色模式或字體大小。
-   **自動更新：** 當 **Environment** 中的值更新時，相關的畫面會自動更新。
-   **get only：** **Environment** 是一個只能讀取 (get) 不能寫入 (set) 的屬性。
-   **修改方式：** 如果要修改 **Environment** 中的值，需要使用調整器 (modifier) 來覆蓋，但這不是真的修改原始的環境變數。
-   **啟動方式：** 使用 **KeyPath** 來存取 **EnvironmentValues** 裡面的環境變數。
-   **常用的環境變數：**
    -   **colorScheme：** 使用者的顏色模式 (淺色或深色)。
    -   **dynamicTypeSize：** 使用者設定的字體大小。
    -   **dismiss：** 用於關閉彈出的畫面。
    -   **editMode：** 顯示編輯模式的狀態。

**程式碼範例**

```swift=
struct MyView: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Circle()
            .fill(colorScheme == .dark ? .pink : .cyan) // 根據顏色模式設定顏色
            .overlay(
                Image(systemName: colorScheme == .dark ? "moon.fill" : "sun.max.fill") // 根據顏色模式設定圖片
            )
    }
}

```

**總結**

-   **Property Wrapper** 是一種用於封裝屬性邏輯的機制，可以重複使用。
-   **State** 用於管理 **Value Type** 的數值，並觸發畫面更新。
-   **Binding** 用於連接 **View** 和資料，讓 **View** 可以修改資料。
-   **Environment** 用於存取系統設定的環境變數，例如顏色模式或字體大小。

## 實作 List、Float Button、AnyLayout


**1\. List (列表) 的使用**

-   **基本用法：** **List** 是一個用於顯示可滾動列表的 **View**。最簡單的使用方式是直接放入資料，並指定如何將每個資料轉換為一個 **View**。
    
    ```swift=
    List(foodExamples, id: \.self) { food in
        Text(food.name)
    }
    
    ```
    
-   **`id` 參數：** **List** 需要一個 **`id`** 參數來識別每個資料。如果資料是 **Identifiable** 的，則不需要額外指定 **`id`**，否則需要指定一個唯一的屬性作為 **`id`**。影片中，最初使用食物的名稱作為 **`id`**，但後來改用 **UUID** 以確保唯一性。
    
-   **刪除和移動：** 可以透過 **`editActions`** 參數來啟用刪除和移動功能。
    
    ```swift=
    List(foodExamples, id: \.id, editActions: .all) { food in
        Text(food.name)
    }
    
    ```
    
-   **`selection` 參數：** 可以使用 **`selection`** 參數來追蹤使用者選中的項目。**`selection`** 參數需要一個 **Binding**，其類型必須與 **List** 中資料的 **`id`** 類型相同。
    
    ```swift=
    @State private var selectedFood: Set<Food.ID> = []
    
    List(foodExamples, selection: $selectedFood) { food in
        Text(food.name)
    }
    
    ```
    
-   **`wrappedValue`：** 當 **List** 中的資料是 **Binding** 時，需要使用 **`wrappedValue`** 來存取實際的值。為了簡化程式碼，可以使用 **`$food`** 來直接存取 **Binding**，而不需要使用 **`food.wrappedValue`**。
    
-   **樣式：** **List** 的預設樣式是 **`insetGrouped`**，這會導致背景顏色和間距上的問題。可以將樣式改為 **`plain`**，並自行添加 **padding** 來解決這些問題。
    
    ```swift=
    List(foodExamples) { food in
         Text(food.name)
    }
    .listStyle(.plain)
    .padding(.horizontal)
    
    ```
    

**2\. 按鈕 (Button) 的製作**

-   **EditButton：** **SwiftUI** 提供了 **`EditButton`** 來快速建立編輯模式的按鈕。
    
-   **新增按鈕：** 可以使用 **`overlay`** 調整器來在 **View** 的上方添加按鈕，並使用 **`alignment`** 參數來控制按鈕的位置。
    
-   **SFSymbol：** **SFSymbol** 是 **Apple** 提供的圖示集。可以使用 **`Image(systemName:)`** 來使用 **SFSymbol**。
    
-   **Label：** **Label** 是一個方便的 **View**，可以將文字和圖片組合在一起。
    
-   **按鈕樣式：** 可以使用 **`buttonStyle`** 調整器來設定按鈕的樣式。影片中使用了一個自訂的 **`mainButtonStyle`**，但後來因為效果不佳而移除。
    
-   **安全區域 (Safe Area)：** 可以使用 **`safeAreaInset`** 調整器來將 **View** 固定在安全區域的邊緣，避免遮擋其他內容。
    
-   **按鈕的動畫效果：** 可以使用 **`withAnimation`** 來添加動畫效果。為了避免動畫導致畫面其他部分重新計算高度，可以使用 **`ZStack`** 來固定 **View** 的大小，並使用 **`opacity`** 和 **`transition`** 來實現動畫效果。
    
-   **轉場效果 (Transition)：** 可以使用 **`transition`** 調整器來設定 **View** 的轉場效果。例如，使用 **`move(edge:)`** 可以讓 **View** 從指定的邊緣滑入滑出。
    
-   **縮放效果 (Scale Effect)：** 可以使用 **`scaleEffect`** 調整器來設定 **View** 的縮放效果。為了讓縮放效果在按鈕的中心點進行，需要將按鈕放在 **HStack** 中，並使用 **Spacer** 來分隔按鈕和空間。
    
    ```swift=
    Button {
        // 按鈕的動作
    } label: {
        Label("食物清單", systemImage: "fork.knife")
    }
    
    ```
    

**3\. SFSymbol 的渲染模式 (Render Mode)**

-   **`systemRenderMode`：** 可以使用 **`systemRenderMode`** 調整器來設定 **SFSymbol** 的渲染模式。**SFSymbol** 有多種渲染模式，包括 **`monochrome`**、**`hierarchical`**、**`palette`** 和 **`multicolor`**。
    
-   **`palette` 模式：** **`palette`** 模式允許設定多種顏色，並使用 **`foregroundStyle`** 調整器來設定這些顏色。
    
    ```swift=
    Image(systemName: "plus.circle.fill")
         .symbolRenderingMode(.palette)
         .foregroundStyle(.white, .accentColor.gradient)
    
    ```
    

**4\. Sheet (表單) 的呈現**

-   **`sheet` 調整器：** 可以使用 **`sheet`** 調整器來呈現一個從底部彈出的 **View**。
    
-   **Binding：** **`sheet`** 需要一個 **Binding** 來決定是否顯示 **sheet**。
    
-   **`presentationDetents`：** 可以使用 **`presentationDetents`** 調整器來設定 **sheet** 的高度。**`presentationDetents`** 接受一組高度選項，使用者可以透過滑動來切換這些高度。
    
    ```swift=
    .sheet(isPresented: $showSheet) {
        Text("Hello")
    }
    
    ```
    
-   **內容排版：** 影片中根據使用者設定的字體大小和文字內容，動態地選擇使用 **HStack** 或 **VStack** 來排版 **sheet** 的內容。
    
-   **AnyLayout：** 可以使用 **`AnyLayout`** 來實現動態排版。**`AnyLayout`** 是一個類型擦除的包裝，它可以包裝任何遵循 **Layout** 協定的類型，例如 **`VStackLayout`** 和 **`HStack`**。這樣可以根據條件動態地選擇不同的排版方式.
    
    ```swift=
    var body: some View {
       let layout = AnyLayout(condition ? VStackLayout() : HStack())
       layout {
            // 要排版的內容
       }
    }
    
    ```
    

**5\. 環境變數 (Environment Variables)**

-   **`@Environment`：** 可以使用 **`@Environment`** 屬性包裝器來讀取環境變數。
    
-   **常用的環境變數：**
    
    -   **`\.editMode`：** 顯示編輯模式的狀態。
    -   **`\.dynamicTypeSize`：** 使用者設定的字體大小。
-   **KeyPath：** 使用 **`KeyPath`** 來存取 **EnvironmentValues** 裡面的環境變數.
    
    ```swift=
    @Environment(\.editMode) var editMode
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    ```
    

**程式碼範例**

```swift=
struct FoodListView: View {
    @State private var foodExamples = [
        Food(name: "漢堡", calories: 500, protein: 20, emoji: "🍔"),
        Food(name: "披薩", calories: 800, protein: 30, emoji: "🍕"),
        Food(name: "義大利麵", calories: 600, protein: 25, emoji: "🍝"),
        Food(name: "雞腿便當", calories: 700, protein: 35, emoji: "🍗🍱")
    ]
    @State private var selectedFood: Set<Food.ID> = []
    @State private var showSheet = false
    @Environment(\.editMode) private var editMode
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    var isEditing: Bool {
        editMode?.wrappedValue == .active
    }

    var body: some View {
        VStack {
            HStack {
                Label("食物清單", systemImage: "fork.knife")
                    .padding(.leading)
                Spacer()
                EditButton()
            }
            .padding(.bottom)

            List(foodExamples, id: \.id, selection: $selectedFood, editActions: .all) { food in
                Text(food.name)
            }
            .listStyle(.plain)
            .padding(.horizontal)

        }
         .overlay(alignment: .bottomTrailing) {
            ZStack {
                if isEditing {
                    Button {
                         foodExamples.removeAll { selectedFood.contains($0.id) }
                     } label: {
                         Text("刪除全部")
                    }
                     .buttonStyle(.borderedProminent)
                     .tint(.red)
                     .controlSize(.large)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .transition(.move(edge: .leading))
                } else {
                    Button {
                         showSheet = true
                     } label: {
                         Image(systemName: "plus.circle.fill")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.white, .accentColor.gradient)
                            .font(.system(size: 50))
                            .padding()
                    }
                    .transition(.scale)
                }
             }
            .frame(maxWidth: .infinity)
        }
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 0) // 讓安全區域延伸
            }
            .sheet(isPresented: $showSheet) {
                FoodDetailView(food: foodExamples.first!)
            }
    }
}


struct Food: Identifiable {
    let id = UUID()
    var name: String
    var calories: Int
    var protein: Int
    var emoji: String
}

struct FoodDetailView: View {
    let food: Food
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    var body: some View {
        let useVStack = dynamicTypeSize.isAccessibilitySize || food.emoji.count > 1

        let layout = AnyLayout(useVStack ? VStackLayout() : HStack())
        layout {
            HStack {
                Text(food.emoji)
                     .font(.system(size: 50))
                layout {
                     NutritionRow(label: "熱量", value: "\(food.calories)大卡")
                     NutritionRow(label: "蛋白質", value: "\(food.protein)克")
                }
            }
            .padding()
        }
    }
}

struct NutritionRow: View {
    let label: String
    let value: String

    var body: some View {
        Grid {
            Text(label)
                .gridCellAnchor(.leading)
             Text(value)
               .gridCellAnchor(.trailing)
        }
    }
}


extension View {
    func mainButtonStyle(shape: ButtonBorderShape = .capsule) -> some View {
        self.buttonStyle(.borderedProminent)
            .tint(.accentColor)
            .controlSize(.large)
            .buttonBorderShape(shape)
    }

    func conditionalLayout(
        useVStack: Bool,
        spacing: CGFloat = 8,
        @ViewBuilder content: @escaping () -> some View
    ) -> some View {
        let layout = AnyLayout(useVStack ? VStackLayout(spacing: spacing) : HStack())

        return layout(content)
    }

}

```

## GeometryReader、PreferenceKey

好的，這份筆記將深入探討影片中關於 **SwiftUI** 如何動態取得畫面大小以及如何使用 **PreferenceKey** 在不同層級的 **View** 之間傳遞資訊的重點。筆記中會包含英文專有名詞對照，並在適當的地方補充程式碼範例：

**1\. 動態取得畫面大小 (Get Dynamic View Size)**

-   **GeometryReader**: **GeometryReader** 是一個 **View**，它可以提供關於其排版空間的資訊。它會提供以下三種資訊：
    
    -   排版畫面的大小 (Size)
    -   在整個畫面中的位置 (Position)
    -   在自己空間中的位置資訊 (Position in its own space)
    -   通常會將 **GeometryReader** 的代理 (Proxy) 命名為 **proxy**。
    -   **GeometryReader** 是一個 **expanding view**，會佔滿所有剩餘空間。
    -   **GeometryReader** 並不負責排版，它只是負責轉交大小資訊。如果沒有設定排版，所有東西會疊在原點。
-   **使用情境**：
    
    -   **佔滿剩餘空間**：當你需要一個 **View** 佔滿所有剩餘空間時，可以使用 **GeometryReader** 來取得位置和大小資訊，幫助你做子畫面的排版。
    -   **LazyGrid**：在 **LazyGrid** 中，可以使用 **GeometryReader** 來計算每個格子的寬度，確保每一格都有相同的寬度。
    -   **計算相對大小和位置**： 可以使用 **GeometryReader** 取得位置資訊，並計算相對大小和位置，例如影片中用來畫米奇。
-   **注意事項**：
    
    -   **ScrollView**: 如果將 **GeometryReader** 放在 **ScrollView** 裡面，它只會拿到最小的空間，不會有任何效果。
    -   **從上往下使用 (Top-Down)**：從上往下使用 **GeometryReader** 是比較常見且直接的方式，但 **GeometryReader** 會撐滿整個畫面，這不一定是我們想要的。

**2\. 從下往上傳遞大小資訊 (Bottom-Up Size Information Transfer)**

-   **問題**: 當子畫面需要將大小資訊傳遞給上層畫面，或者更遠的地方時，不能直接使用 **GeometryReader**，因為 **GeometryReader** 會取得它所在位置的尺寸，而不是子畫面本身的尺寸。
-   **解決方案**:
    -   **background/overlay**: 將 **GeometryReader** 放在子畫面的 **background** 或 **overlay** 上。 這樣 **GeometryReader** 才能取得子畫面的實際大小。
    -   **State**: 可以將 **GeometryReader** 讀取到的尺寸儲存在一個 **State** 變數中，並利用這個 **State** 來觸發畫面更新。
    -   **注意事項**：直接使用 **State** 來改變上層畫面的大小或位置可能會導致奇怪的結果，或是讓 **View** 不斷重新渲染。

**3\. PreferenceKey (偏好鍵)**

-   **概念**: **PreferenceKey** 是一種讓子畫面可以將偏好資訊傳遞給上層畫面的機制。上層畫面可以讀取這些偏好資訊，並用來建立其它圖層的 **View**。
-   **運作方式**:
    1.  **建立 Key**: 需要先建立一個遵循 **PreferenceKey** 協定的 **Key**。
    2.  **預設值 (defaultValue)**: **Key** 必須有一個預設值，以防沒有子畫面提供偏好。
    3.  **reduce function**: **Key** 需要一個 **reduce** 函數，當有新的值傳入時，決定如何選擇或運算這些值。
    4.  **設定偏好**: 在子畫面中使用 **.preference()** 設定偏好值。
    5.  **讀取偏好**: 在上層畫面使用 **.background()** 或 **.overlay()** 加上 **.preference()** 讀取偏好值。
-   **優點**:
    -   **安全**：在上層讀取來自子畫面的偏好並建立其它圖層時，不會影響到原先的子畫面。
    -   **彈性**：可以在任何上層位置讀取偏好，不一定需要是直接上層。
-   **實際應用**：
    -   **顏色偏好**：設定子畫面的顏色偏好，並在上層根據這個偏好設定背景顏色。
    -   **尺寸偏好**：設定子畫面的尺寸偏好，並在上層根據這個偏好來調整其他 **View** 的大小。

**4\. onPreferenceChange (偏好改變)**

-   **用途**: 當我們需要在同一個圖層中，根據子畫面的偏好資訊來改變其他 **View** 的狀態時，可以使用 **onPreferenceChange** 調整器。
-   **使用方法**:
    1.  **設定 Key**: 和 **PreferenceKey** 的使用方式一樣，需要先設定一個 **Key**。
    2.  **讀取偏好**: 使用 **.onPreferenceChange()** 調整器來讀取偏好值。
    3.  **觸發更新**: 當偏好值改變時，觸發 **State** 的更新，進而改變畫面.
-   **注意事項**: 使用 **onPreferenceChange** 時，仍然需要注意先後順序，以及這個改動是否會導致多次排版變化。

**5\. 程式碼範例**

以下是一個簡化的程式碼範例，展示如何使用 **GeometryReader** 和 **PreferenceKey** 來取得子畫面的大小，並用來調整上層畫面的背景顏色和顯示文字：

```swift=
import SwiftUI

struct ContentView: View {
    @State private var fishSize: CGSize = .zero
    @State private var bgColor: Color = .accentColor

    var body: some View {
        VStack {
            Text("魚的大小：\(fishSize.width) x \(fishSize.height)")
                .background(bgColor)
                .padding()

            FishView()
                .onPreferenceChange(FishSizeKey.self) { newSize in
                    fishSize = newSize
                    bgColor = newSize.width > 200 ? .indigo : .yellow

                }
        }
    }
}

struct FishView: View {
    var body: some View {
        Image(systemName: "fish.fill")
            .font(.system(size: 100))
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: FishSizeKey.self, value: proxy.size)
                }
             )
    }
}

struct FishSizeKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}


#Preview {
    ContentView()
}


```

**重點整理：**

-   **GeometryReader**: 用於動態取得 **View** 的尺寸和位置資訊。
-   **PreferenceKey**: 用於在不同層級的 **View** 之間安全地傳遞偏好資訊，不影響原先的 **View**。
-   **onPreferenceChange**: 用於在同一個圖層中，根據子畫面的偏好資訊來改變其他 **View** 的狀態。
-   **background/overlay**: 搭配 **GeometryReader** 使用，確保可以讀取到子畫面的實際大小。
-   **State**: 用於儲存 **GeometryReader** 或 **PreferenceKey** 讀取到的資訊，並觸發畫面更新。
-   **擴展的 View (expanding View)**: **GeometryReader** 本身是 expanding 的，會盡可能佔據空間。

## Form、FocusState、Keyboard、Sheet


**1\. 表單 (Form) 的建立與使用**

-   **Form**: `Form` 是一個 **View**，用於建立具有預設樣式的表單。它會提供一些預設的風格，類似於 **List**，但風格不同。
    -   `Form` 是一個 **expanding view**，會被推到最上方。
    -   可以在 `Form` 中加入 **Section** 來區隔內容，並設定 header 和 footer。
    -   `Form` 提供預設的分組風格 (group)，可以設定為 columns 讓 header、footer 和內容在一列顯示。
-   **TextField**: `TextField` 是一個文字輸入框，可以讓使用者輸入文字。
    -   需要一個標題 (title) 和一個 **Binding** 來指示文字要修改的位置。
    -   可以使用 **State** 來建立只在這個 **View** 內修改的資料，或是使用 **Binding** 直接修改外部的資料。
    -   使用 **State** 時，修改只會發生在這個畫面中，需要按下儲存按鈕才會覆蓋原始資料。
    -   可以使用 **LabeledContent** 來同時顯示標題和輸入框，並設定提示文字。
-   **背景**: 可以使用 `.background(.group)` 來讓整個 **VStack** 套用 group 的背景。
-   **對齊**: 可以使用 `.multilineTextAlignment(.trailing)` 將文字靠右對齊。

**2\. 數字輸入欄位 (Number Field)**

-   當需要使用者輸入數字時，不能直接使用 **TextField** 連接到非 `String` 的 **Binding**。
-   可以使用帶有格式化的 **TextField**，例如 `.textField(value:formatter:)`，來轉換 **Binding** 的資料格式。
    -   可以使用 **NumberFormatter** 來設定小數點位數。
-   可以使用 **HStack** 來將數字欄位和單位並排顯示。

**3\. 按鈕 (Button) 與啟用/停用狀態**

-   可以使用 `Button` 來建立按鈕，並設定按鈕的 action 和 label。
-   可以使用 `.mainButtonStyle` 來套用按鈕樣式。
-   可以使用 `.disabled(true/false)` 來設定按鈕的啟用/停用狀態。
    -   當 **disabled** 設定為 true 時，按鈕會無法點擊。
-   可以根據輸入內容是否符合要求，來動態設定按鈕是否停用。
-   可以根據輸入內容的錯誤訊息，來動態更改按鈕上的文字提示。

**4\. Sheet 的顯示與管理**

-   可以使用 `.sheet(isPresented:content:)` 來顯示 sheet。
    -   需要設定一個 **State** 變數 (例如 `shouldShowFoodForm`) 來控制 sheet 的顯示與否。
-   可以使用 `.sheet(item:content:)` 來顯示 sheet，並傳遞要顯示的資料。
    -   這個方法會觀察 **Binding**，當 **Binding** 的值從沒有變成有時，就會顯示 sheet。
-   **Environment** 的 `dismiss` 可以用來關閉目前的 **presentation**，包括 sheet。
-   為了更好的使用者體驗，應該加上關閉按鈕，並使用 `dismiss` 來關閉 sheet。
-   可以使用 `.padding(.horizontal)` 和 `.padding(.top)` 來調整 **HStack** 的 padding。
-   可以使用 `.scrollDismissesKeyboard(.interactively)` 讓鍵盤在滑動時可以互動地關閉。
-   sheet 在橫向時無法下拉關閉，所以需要額外加上關閉按鈕。

**5\. TextField 的鍵盤設定**

-   可以使用 `.submitLabel(.next)` 來設定鍵盤上的 return 按鈕顯示為 next。
-   可以使用 `.keyboardType(.decimalPad)` 來設定鍵盤為數字鍵盤。
-   `decimalPad` 鍵盤不會顯示 next 按鈕，需要使用 toolbar 來加入切換欄位的按鈕。

**6\. FocusState 與欄位焦點管理**

-   **FocusState**: `@FocusState` 是一個 **Property Wrapper**，用來追蹤哪個文字欄位正在編輯中。
    -   必須是 Optional 的，因為可能沒有任何欄位正在編輯。
-   **Enum**: 可以使用 **enum** 來定義欄位的順序，方便管理欄位的焦點。
-   可以使用 `.focused($field, equals: .title)` 來設定當欄位等於某個值時，該 **TextField** 進入編輯狀態。
-   可以使用 `.onSubmit` 來設定按下鍵盤上的 next 按鈕後要執行的動作，例如切換到下一個欄位。

**7\. 鍵盤工具列 (keyboard toolbar)**

-   可以使用 `.toolbar` 調整器來設定鍵盤工具列.
-   `toolbar` 必須放在 **NavigationStack** 裡面才會生效.
-   可以使用 `ToolbarItem(placement: .keyboard)` 來將工具列放在鍵盤上方.
-   可以使用 `ToolbarItemGroup(placement: .keyboard)` 來放置多個按鈕.
-   可以在工具列上加入按鈕，來切換上一個或下一個欄位.

**8\. View 的擴展 (Extension)**

-   可以使用 **extension** 來擴展 **View** 的功能，例如將常用的 modifier 提取出來.
-   **extension** 可以加在特定類型的 **View** 上，例如 `extension TextField`，並使用 Generic 來限制類型.

**9\. 資料傳遞與更新**

-   在 sheet 中，可以使用 **Binding** 來直接修改外部的資料。
-   可以使用 closure 來傳遞資料，例如 onSubmit，讓 sheet 關閉後執行特定的動作.
-   可以使用 **enum** 來管理不同的 sheet 類型，並將產生 view 的邏輯放在 enum 裡面.
-   enum 可以遵循 **View** 協定，直接變成一個 **View**.
-   enum 可以遵循 **Identifiable** 協定，讓 sheet 可以使用 item 來啟動.

**10\. 程式碼範例 (簡化)**

```swift=
import SwiftUI

enum MyField: Int, CaseIterable {
    case title, image, calories, protein, fat, carbs
}
struct Food: Identifiable {
    let id = UUID()
    var name: String = ""
    var image: String = ""
    var calories: Double = 0
    var protein: Double = 0
    var fat: Double = 0
    var carbs: Double = 0
}
struct FoodForm: View {
    @State var food: Food
    @FocusState private var field: MyField?
    var onSubmit: (Food) -> Void
    @Environment(\.dismiss) var dismiss

    var isNotValid: Bool {
        food.name.isEmpty || food.image.count > 2
    }

    var errorMessage: String? {
        if food.name.isEmpty {
            return "請輸入名稱"
        } else if food.image.count > 2 {
            return "圖示字數過多"
        }
        return nil
    }

    var body: some View {
        NavigationStack {
        VStack {
           HStack {
            Label("編輯食物資訊", systemImage: "pencil")
            Spacer()
               Button {
                 dismiss()

               } label: {
                 Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundColor(.secondary)
            }

           }
            .padding(.horizontal)
            .padding(.top)

            Form {
                LabeledContent("名稱") {
                    TextField("必填", text: $food.name)
                        .focused($field, equals: .title)
                        .myTextFieldModifier($field, field: .title)

                }
                LabeledContent("圖示") {
                    TextField("最多輸入兩個字", text: $food.image)
                        .focused($field, equals: .image)
                        .myTextFieldModifier($field, field: .image)
                }
                LabeledContent("熱量") {

                    TextField("", value: $food.calories, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($field, equals: .calories)
                        .myTextFieldModifier($field, field: .calories)
                    HStack{
                        Spacer()
                        Text("大卡")
                    }

                }
                LabeledContent("蛋白質") {
                    TextField("", value: $food.protein, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($field, equals: .protein)
                        .myTextFieldModifier($field, field: .protein)
                    HStack{
                        Spacer()
                        Text("g")
                    }
                }
                LabeledContent("脂肪") {
                    TextField("", value: $food.fat, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($field, equals: .fat)
                        .myTextFieldModifier($field, field: .fat)
                    HStack{
                        Spacer()
                        Text("g")
                    }
                }
                LabeledContent("碳水") {
                    TextField("", value: $food.carbs, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($field, equals: .carbs)
                        .myTextFieldModifier($field, field: .carbs)
                    HStack{
                        Spacer()
                         Text("g")
                    }
                }
            }
            .padding(.top, -16)
        }
         .multilineTextAlignment(.trailing)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button {
                    goPreviousField()
                } label: {
                    Image(systemName: "chevron.up")
                }
                Spacer()
                Button {
                    goNextField()
                } label: {
                    Image(systemName: "chevron.down")
                }
            }
        }
        .background(.group)

            Button {
                dismiss()
                onSubmit(food)
            } label: {
                Text(errorMessage ?? "儲存")
                    .fontWeight(.bold)
            }
            .mainButtonStyle()
            .disabled(isNotValid)
            .padding()
        }
    }

    func goPreviousField() {
      guard let field = field else { return }
        self.field = MyField(rawValue: field.rawValue - 1)
    }

    func goNextField() {
        guard let field = field else { return }
        self.field = MyField(rawValue: field.rawValue + 1)
    }
}


extension TextField {

    func myTextFieldModifier<Label>(_ field: FocusState<MyField?>.Binding, field: MyField) -> some View  {
        self
        .submitLabel(field == .carbs ? .done : .next )
            .onSubmit {
                if field == .carbs {

                }else {
                    self.field = MyField(rawValue: field.rawValue + 1)

                }

            }
                .focused(field, equals: field)
    }
}

extension View {
    func mainButtonStyle() -> some View {
        modifier(MainButtonStyle())
    }
}

struct MainButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}

#Preview {
    FoodForm(food: Food()) { food in
        print(food)
    }
}

```

**重點整理：**

-   **Form**: 用於建立具有預設樣式的表單。
-   **TextField**: 用於接收使用者輸入的文字。
-   **Binding**: 用於連結 **View** 和資料，實現雙向綁定。
-   **State**: 用於管理 **View** 內部的狀態。
-   **FocusState**: 用於追蹤哪個文字欄位正在編輯中。
-   **sheet**: 用於顯示模態視窗。
-   **toolbar**: 用於設定鍵盤工具列。
-   **enum**: 用於定義欄位順序和管理不同類型的 sheet。
-   **extension**: 用於擴展 **View** 的功能，提取常用的 modifier。

## Refactor: Folder Structure, Enum ...

**程式碼重構：資料夾架構與 enum 管理 icon**

-   **目標：**
    
    -   改善程式碼的可讀性與可維護性。
    -   將程式碼依照功能分類，避免單一檔案過於龐大。
    -   系統化管理 App 中使用的圖示 (icons)。
-   **資料夾架構 (Folder Structure):**
    
    -   **Screen:** 存放畫面的相關程式碼。
        -   將 `ContentView` 更名為 `FoodPickerScreen`。
        -   `FoodListView` 移至 Screen 資料夾。
        -   在 Screen 資料夾下，再依照個別畫面 (screen) 建立子資料夾 (subfolder) ，如 `FoodPicker` 和 `FoodList`。
        -   將 `FoodForm` 放入 `FoodList` 資料夾中，因為它屬於 `FoodList` 的一部分。
    -   **Model:** 存放資料模型，在此專案中只有 `Food`。
    -   **Extension:** 存放擴展 (extension) 程式碼。
        -   將所有 extension 放在此資料夾中，方便管理。
        -   可以針對不同的 extension 類型再細分，如 `View+Style` 或 `View+Size`。
    -   **Resource:** 存放外部資源，例如 asset。
    -   **Utilities:** 存放如 property wrapper 等工具類程式碼。
    -   **AppEntry:** 將 `FoodPickerApp` 更名為 `AppEntry`，並置於最上層，作為 App 的入口點。
    -   **Constant:** 存放常數，如 SFSymbol 的 enum。
-   **程式碼整理重點 (Code Refactoring):**
    
    -   **將 View 從畫面中拆分出來:** 將 `FoodDetailSheet` 和 `Sheet` 從 `FoodListScreen` 中拆分到各自的 View 檔案中。
    -   **調整權限 (Access Control):**
        -   原本 `fileprivate` 的屬性，若在不同檔案中使用，需改為 `internal`。
        -   只在單一檔案內使用的 `struct` 可以設為 `private`。
    -   **減少無意義的 closure:** 將 `.sheet` 的 closure 提取到 extension 中，增加可讀性。
    
    ```swift=
    // Extension for View
    extension View {
        func sheet<Item: View & Identifiable>(item: Binding<Item?>) -> some View {
            self.sheet(item: item) { item in
                item
            }
        }
    }
    
    // 在 FoodListScreen 中的使用
    .sheet(item: $selectedFood) { food in
        FoodDetailSheet(food: food)
    }
    
    ```
    
-   **使用 enum 管理 SF Symbols:**
    
    -   建立 `SFSymbol` 的 enum 來管理所有 icon 的名稱。
    -   使用 enum 的 `rawValue` 來儲存 icon 的名稱。
    
    ```swift=
    // Constant/SFSymbol.swift
    import SwiftUI
    enum SFSymbol: String {
        case circle
        case forkAndKnife = "fork.knife"
        case plus
        case pencil
    }
    
    // 在 View 中使用
    Image(systemName: SFSymbol.plus.rawValue)
    
    ```
    
    -   為 `Label` 擴展一個使用 `SFSymbol` 的初始化方法，簡化程式碼.
    
    ```swift=
    // Extension/Label+SFSymbol.swift
    import SwiftUI
    extension Label where Title == Text, Icon == Image {
        init(_ title: String, systemImage: SFSymbol) {
            self.init(title, systemImage: systemImage.rawValue)
        }
    }
    // 使用方式
    Label("Fork and Knife", systemImage: .forkAndKnife)
    
    ```
    
    -   將 `SFSymbol` 擴展為 `View`，並加入 `resizable()` 等 modifier，方便調整。
    
    ```swift=
    // Extension/SFSymbol+View.swift
    import SwiftUI
    extension SFSymbol: View {
        var body: Image {
             Image(systemName: self.rawValue)
        }
    
        func resizable() -> Image {
            self.body.resizable()
        }
    }
    
    // 使用方式
     SFSymbol.plus.resizable()
    
    ```
    
-   **自訂 View Modifier:**
    
    -   為 `frame` 建立自訂的 modifier `push`，方便設定 view 的對齊方式。
    
    ```swift=
    // Extension/View+Frame.swift
    import SwiftUI
    extension View {
        func push(to alignment: TextAlignment) -> some View {
            frame(maxWidth: .infinity, alignment: alignment.alignment)
        }
        // Helper function
        func maxWidth() -> some View {
            push(to: .center)
        }
    }
    // 使用方式
    .push(to: .leading)
    .maxWidth()
    
    ```
    
    -   使用 `TextAlignment` enum 作為參數，簡化程式碼.
        
    -   建立 helper function 如 `maxWidth()` 來提供預設值.
        
    -   使用 document 注解來解釋 helper function 的用途.
        
        -   使用三條斜線 `///` 來添加文件註解.
        -   使用 `x-source-tag` URL Scheme 建立連結.
        
        ```swift=
        /// 這是一個 push 的快捷方式
        /// 它使用了 [push](x-source-tag://push) 這個調整器
        func maxWidth() -> some View {
            push(to: .center)
        }
        
        ```
        
-   **其他程式碼調整:**
    
    -   簡化 `HStack` 與 `Spacer` 的使用，改用 `push(to: .trailing)`。
    -   將 `toolbar` 內的程式碼提取成 closure，增加可讀性。
    -   了解 `toolbar` 的兩種 closure 類型：回傳 `View` 或 `ToolbarContent`。
    -   建立 `readGeometry` 的 modifier，方便讀取 `GeometryReader` 的資料。
    
    ```swift=
    // Extension/View+Geometry.swift
    extension View {
        func readGeometry<Key: PreferenceKey, Value>(
            _ key: Key.Type,
            keyPath: KeyPath<GeometryProxy, Value>
        ) -> some View where Key.Value == Value {
                GeometryReader { proxy in
                  Color.clear
                      .preference(key: key, value: proxy[keyPath: keyPath])
              }
        }
    }
    
    // 使用範例
    .readGeometry(HeightPreferenceKey.self, keyPath: \.size.height)
    
    ```
    
-   **extension 的分類:**
    
    -   將 extension 分散到不同的檔案中，並以 `+` 符號標示，例如 `View+Frame.swift`.
    -   可以根據功能或類型進一步細分，如 `View+Style` 或 `View+Size`。
-   **總結:**
    
    -   透過以上步驟，程式碼的結構變得更加清晰易懂。
    -   每個檔案的功能更加明確，方便後續維護與擴充。
    -   系統化的管理方式，減少程式碼重複，提高開發效率。

## UserDefaults & AppStorage



**資料持久化：UserDefaults 和 AppStorage**

-   **資料的生命週期 (Data Lifecycle):**
    
    -   **記憶體 (Memory):** 程式執行時產生的資料通常存在記憶體中。
        -   記憶體空間有限，資料只在需要時佔用空間。
        -   **靜態屬性 (static property):** 在程式建立時出現，結束時消失。
        -   **Closure 內的資料:** 在 closure 執行時暫時佔用記憶體，執行完畢後釋放。
        -   **實例 (instance):** 當沒有地方可以連結到資料時，記憶體空間就會被釋放。
        -   **重點:** 記憶體中的資料最多只會維持到程式結束。
    -   **硬碟 (Hard Drive):** 若要讓資料獨立於程式之外，必須將資料儲存到硬碟中。
        -   這裡的硬碟是指使用者的裝置或雲端。
        -   與記憶體不同，硬碟負責保管資料。
    -   **比喻:**
        -   **記憶體:** 像是共享的工作桌，方便快速工作，但空間有限。
        -   **硬碟:** 像是抽屜，可以長期存放資料，但需要時要花時間取出。
        -   **雲端服務:** 像是同事，需要溝通才能取得資料。
    -   **小結:** 記憶體是程式執行時暫時使用的地方，硬碟則是長期存放資料的地方。
-   **使用者裝置上儲存資料的方法:**
    
    -   **UserDefaults:**
        -   **以 Key-Value 配對 (key-value pair)** 的 plist 檔案儲存。
        -   適合儲存**資料小**且**常用**的資料。
        -   程式啟動時會**自動讀入記憶體**，存取速度快。
        -   **沒有安全機制**，不適合存放密碼等重要資訊。
        -   適合儲存使用者設定 (user defaults)，例如單位表示方式、排序方式、顏色設定等。
        -   **plist 支援的類型有限**，例如 Boolean、Integer、Float、Double、String、Date、Data、Array、Dictionary 等，若要儲存自定義的類型需透過 Codable 轉換為 Data.
        -   無法控制資料存回硬碟的時間點，更新時會先更新記憶體中的值，系統決定何時存回硬碟。
            -   編輯後立即關閉 app 可能會遺失資料，測試時需等待幾秒再重開。
        -   tvOS 上有空間限制，最多 1 MB。
        -   可以在不同線程安全地存取。
        -   **取得實例 (instance):** 透過靜態屬性 `standard` 取得預設的 plist 檔案的單例 (singleton)。
            -   不應重複建立實例，應使用單例模式。
        -   可以自訂名稱建立新的 plist 檔案，或使用 AppGroup 設定的名稱以跨 target 使用資料。
            -   不能使用 App 的 Bundle ID 或 Global Domain 名稱，否則會啟動失敗並回傳 `nil`。
        -   **儲存資料:** 使用 `set` 方法，需搭配 String 類型的 key。雖然可放入 Any 類型，但僅限 plist 支援的類型，否則會報錯。
        -   **刪除資料:** 使用 `removeObject` 方法，可完全刪除 key 與其值，若使用 set 設定 key 的值為 `nil`，則 key 仍然存在。
        -   **讀取資料:** 根據不同類型有不同的讀取方法，部分類型有預設值（如 Boolean 的 `false`，數字的 `0`），可能導致判斷錯誤。
            -   建議使用 `object(forKey:)` 方法並自行處理類型轉換和空值。
        -   **設定預設值:** 使用 `register` 方法，可設定每個 key 的預設回傳值，但此設定不會寫入 plist 檔案，程式每次啟動都需執行此方法。
        -   **程式碼範例:**
            
            ```swift=
             // 取得預設 UserDefaults 實例
             let userDefaults = UserDefaults.standard
            
             // 儲存資料
             userDefaults.set("John", forKey: "userName")
             userDefaults.set(25, forKey: "userAge")
            
             // 讀取資料
             let name = userDefaults.string(forKey: "userName")
             let age = userDefaults.integer(forKey: "userAge")
            
             // 移除資料
              userDefaults.removeObject(forKey: "userName")
            
              // 設定預設值
              userDefaults.register(defaults: ["userAge": 30])
            
            
            ```
            
    -   **FileManager:**
        -   如同電腦上的檔案總管，可儲存檔案到桌面或文件等位置。
        -   適合儲存**較大**或**較少用**的資料。
        -   速度相對較慢，因為需要從硬碟讀取。
        -   **沒有安全機制**，不適合存放密碼等重要資訊。
    -   **CoreData:**
        -   底層使用 SQLite，適合儲存**有關聯性**的資料。
        -   例如學校的課程、老師、學生等資料，可以快速查找特定條件的資料。
        -   **沒有加密機制**，不適合儲存機密資料。
    -   **KeyChain:**
        -   **唯一有加密處理**的儲存方式，適合儲存密碼或 Token。
        -   速度不是重點，重點在於 Apple 原生提供的加密機制。
-   **AppStorage:**
    
    -   結合了 UserDefaults 的值和 State，在修改時可更新 UserDefaults 並通知畫面更新。
    -   **支援的類型較少**，預設只支援 Boolean, Int, Double, String, URL, Data，可透過讓類型遵循 RawRepresentable 並將 RawValue 設為 String 或 Int 來增加支援的類型。
    -   投射類型 (projected type) 與 State 一樣是 Binding。
    -   **建立方法:** 在括號中放入 key，後面寫預設值，預設值概念與 register 相同，若已 register 過則會使用 register 設定的值。
    -   **程式碼範例:**
        
        ```swift=
        import SwiftUI
        
        struct ContentView: View {
          @AppStorage("isDarkMode") private var isDarkMode = false
          @AppStorage("userAge") private var age = 18 // 預設值為 18
        
            var body: some View {
                Toggle("Dark Mode", isOn: $isDarkMode)
                  Text("Age: \(age)")
        
            }
        }
        
        ```
        
-   **UserDefaults 的小技巧:**
    
    -   可在 Scheme 中設定某個 Key 的固定值，方便測試，此設定僅在啟動時生效，不會真的寫入。
    -   設定方法：在 Scheme 的 Arguments 中加入 `-key value`。
-   **SceneStorage:**
    
    -   與 AppStorage 的用法和功能類似，但作用範圍僅限於 Scene。
    -   底層 API 沒有公開，僅能透過屬性包裝存取。
    -   主要用於回復 Scene 的狀態，若使用者主動關閉 Scene，則資料無法復原。
    -   不同 Scene 的 SceneStorage 不共通。

## TabView, ignoreSafeArea


**TabView 的實作與應用**

-   **基本概念：** `TabView` 是一個可以讓使用者在多個畫面之間切換的容器。
    
    -   它會在畫面的底部顯示按鈕 (Tab Buttons)，點擊這些按鈕可以切換不同的畫面。
    -   每個按鈕都對應到一個不同的視圖 (View)。
    -   `TabView` 可以透過 `tabItem` 調整器 (modifier) 來設定每個按鈕的樣式。
    -   可以使用 `tabViewStyle` 調整器來改變 `TabView` 的外觀，例如使用 page 樣式來實現左右滑動翻頁的效果。
-   **`TabView` 的基本使用方法:**
    
    -   在 `TabView` 的 closure 內放入要顯示的內容，例如 Text 視圖。
        
        ```swift=
        TabView {
            Text("畫面 1")
            Text("畫面 2")
        }
        
        ```
        
    -   使用 `tabItem` 調整器來設定每個畫面的按鈕樣式。
    
    ```swift=
        TabView {
            Text("畫面 1")
                .tabItem {
                    Text("按鈕 1")
                }
            Text("畫面 2")
                .tabItem {
                    Text("按鈕 2")
                }
        }
    
    ```
    
-   **使用 `selection` 參數：**
    
    -   `selection` 參數可以讓你更精確地控制目前選中的 tab。
    -   它需要一個 Binding (綁定) 參數，通常會使用 `@State` 宣告一個變數來儲存目前選中的 tab 的值。
    
    ```swift=
        @State private var selectedTab = 0
    
        TabView(selection: $selectedTab) {
            Text("畫面 1")
                .tabItem {
                    Text("按鈕 1")
                }
                .tag(0)
            Text("畫面 2")
                .tabItem {
                    Text("按鈕 2")
                }
                .tag(1)
        }
    
    ```
    
    -   可以使用 `tag` 調整器來為每個畫面設定一個唯一的值，以便 `TabView` 知道哪個畫面應該被顯示。
    -   `tag` 接受任何 **Hashable** 的值，例如整數或字串。
    -   當 `selection` 的值改變時，`TabView` 會自動切換到對應的畫面。
    -   `tag` 的用途是區分 `TabView` 中可以被選擇的畫面，跟 `id` 用來設定 View 的身份不同。
    -   **當使用 `ForEach` 建立一組畫面時，這些畫面會自動被加上 `tag`，而 `tag` 的值就是你設定的 `id`**。
-   **`tabItem` 的內容：**
    
    -   `tabItem` 內可以放置任何視圖，例如文字 (Text)、圖片 (SFSymbol) 或 Label。
    -   可以使用 `LabelStyle` 來調整 `Label` 的樣式，例如只顯示圖示 (icon) 而不顯示文字。
        
        ```
        .tabItem {
            Label("首頁", systemImage: "house")
        }
        .labelStyle(.iconOnly)
        
        ```
        
-   **`TabView` 的應用實例：**
    
    -   影片中示範了如何將 `ListView` (食物列表) 和 `PickerScreen` (食物選擇器) 結合到 `TabView` 中，讓使用者可以在這兩個畫面之間切換。
    -   在 `ListView` 中加入編輯按鈕 (EditButton) 和新增按鈕，並調整按鈕的位置和樣式。

**`ignoreSafeArea` 調整器的使用**

-   **基本概念:** `ignoreSafeArea` 調整器可以讓視圖忽略安全區域 (safe area)，使其可以延伸到螢幕的邊緣。
    
-   **使用方法：**
    
    -   `ignoreSafeArea()`：預設會忽略所有的安全區域。
    -   `ignoreSafeArea(edges: .bottom)`：只忽略底部的安全區域。
    -   `ignoreSafeArea(regions: .container)`: 忽略容器 (container) 的安全區域。
    -   `ignoreSafeArea(regions: .keyboard)`: 忽略鍵盤 (keyboard) 的安全區域。
    -   可以搭配 closure 使用，以便在調整器中放入形狀 (Shape) 或其他視圖，並只針對這些視圖套用忽略安全區域的效果。
-   **與背景 (background) 搭配使用：**
    
    -   `ignoreSafeArea` 通常會與 `background` 調整器一起使用，以確保背景顏色或圖片可以延伸到螢幕邊緣。
    -   當直接在 `background` 後面設定 `cornerRadius` 時，背景的範圍會變小。
    -   為了讓背景有圓角且能忽略安全區域，需要使用 `background` 的 closure 版本，並在 closure 中加入形狀，再對此形狀使用 `ignoreSafeArea`。
        
        ```
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray)
                .ignoreSafeArea()
        }
        
        ```
        
-   **安全區域類型 (regions) ：**
    
    -   **container:** 指的是裝置螢幕的邊界，不包含鍵盤彈出時所佔據的空間。
    -   **keyboard:** 指的是鍵盤彈出時，鍵盤上方所形成的邊界。
    -   **all:** 預設值，同時忽略容器和鍵盤的安全區域。
-   **注意事項：**
    
    -   當 List 使用 `plain` 樣式時，預設背景會變成透明的。
    -   為了讓 `List` 的背景顏色正常顯示，需要為其加上背景顏色。
    -   使用 `ignoreSafeArea` 時，要特別注意其位置，避免造成畫面元素重疊或無法正常顯示。
    -   當 `List` 忽略安全區域時，原本在安全區域內的按鈕可能會被遮擋。
    -   為了解決這個問題，需要使用 `background` 的 closure 版本，並在 closure 中加入形狀，再對此形狀使用 `ignoreSafeArea`，並且要確保按鈕的放置位置，如使用 `safeAreaInset`.

**其他重點**

-   **程式碼片段 (code snippet):** 為了方便管理 Tab，可以使用 `enum` 來管理畫面，並建立一個自定義的 code snippet，但要注意這種寫法與 SwiftUI 的設計理念不同，不建議在正式專案中使用。
-   **編輯模式 (EditMode) 的 bug:** 在某些情況下，`TabView` 內部的 `EditMode` 變化可能無法觸發畫面更新，需要將環境變數 `EditMode` 轉為 `State` 來管理。
-   **GeometryReader:** 可以取得畫面精確的高度，用來動態調整畫面的高度以適應不同的安全區域和 TabView 高度.
-   **深色模式 (Dark Mode):** 在深色模式下，要注意背景顏色和文字顏色的對比，確保畫面在不同模式下都能正常顯示。
-   **SFSymbol:** 可以使用 `SFSymbol` 來顯示系統提供的圖示.

## UserDefaults, Color Mode

**設定畫面 (Setting Screen) 的建立**

-   **基本架構：** 使用 `Form` 作為設定畫面的基礎，並利用 `Section` 來區分不同的設定區塊，例如「基本設定 (Basic Settings)」和「危險區域 (Danger Zone)」。
-   **`Section` 的使用：** `Section` 可以將設定選項分組，並顯示標題。
-   **深色模式 (Dark Mode) 切換：**
    -   使用 `Toggle` 視圖來實現深色模式的開關。
    -   `Toggle` 需要一個布林值 (Boolean) 的 `Binding` 來控制開關狀態，可以使用 `@State` 變數來儲存這個值。
    -   範例程式碼：
        
        ```swift=
        @State private var shouldUseDarkMode = false
        
        Toggle("深色模式 (Dark Mode)", isOn: $shouldUseDarkMode)
        
        ```
        
-   **單位 (Unit) 選擇：**
    -   使用 `Picker` 視圖來讓使用者選擇單位，例如公克 (gram, g) 或磅 (pound, lb)。
    -   `Picker` 是一個多選一的選擇器，需要一個 `selection` 參數來儲存使用者選中的項目，並在 `content` 參數中提供選項。
    -   使用 `enum` 來定義選項，並讓 `enum` 遵循 `CaseIterable` 和 `Identifiable` 協定，以便在 `ForEach` 中使用。
    -   為 `enum` 設定 `rawValue` 為 `String`，以便顯示文字。
    -   範例程式碼：
        
        ```swift=
        enum Unit: String, CaseIterable, Identifiable {
            case gram
            case pound
        
            var id: Self { self }
        
            var rawValue: String {
                switch self {
                case .gram:
                    return "g"
                case .pound:
                    return "lb"
                }
            }
        }
        
        @State private var selectedUnit: Unit = .gram
        
        Picker("單位 (Unit)", selection: $selectedUnit) {
            ForEach(Unit.allCases) { unit in
                Text(unit.rawValue)
            }
        }
        
        ```
        
    -   `Picker` 提供多種 `Style`，例如 `wheel` (滾輪式)、`segmented` (分段式)、`inline` (內嵌式) 和 `navigationLink` (導航連結式)。
-   **啟動畫面 (Start Tab) 設定：**
    -   使用 `Picker` 視圖讓使用者選擇啟動畫面，例如「隨機食物 (Random Food)」或「食物清單 (Food List)」。
    -   使用 `enum` 來定義不同的 Tab 選項。
    -   範例程式碼：
        
        ```swift=
        @State private var startTab: HomeScreen.Tab = .picker
        
         Picker("啟動畫面 (Start Tab)", selection: $startTab) {
              Text("隨機食物 (Random Food)").tag(HomeScreen.Tab.picker)
              Text("食物清單 (Food List)").tag(HomeScreen.Tab.list)
         }
        
        ```
        
-   **危險區域 (Danger Zone)：**
    -   使用 `Button` 搭配 `confirmationDialog` 調整器來實現需要再次確認的動作，例如「重置設定 (Reset Settings)」和「重置食物紀錄 (Reset Food Records)」。
    -   `confirmationDialog` 可以設定標題 (title)、訊息 (message) 和動作 (action).
    -   `action` 必須是 `Button` 類型的視圖。
    -   可以為 `Button` 設定 `role`，例如 `cancel` 或 `destructive` (破壞性的)。
    -   使用 `enum` 來管理 `confirmationDialog` 的狀態，以便在不同按鈕上顯示不同的訊息和動作。
    -   `confirmationDialog` 的 `isPresented` 參數需要一個 `Binding<Bool>`，可以透過計算屬性 (computed property) 來實現.
        
        ```swift=
          @State private var confirmationDialog: Dialog? = .inactive
        
          private var isShowingDialog: Binding<Bool> {
              Binding(
                  get: { confirmationDialog != .inactive },
                  set: { _ in confirmationDialog = .inactive }
              )
          }
        
        Button("重置設定 (Reset Settings)") {
            confirmationDialog = .resetSettings
        }
        .confirmationDialog(
             confirmationDialog?.rawValue ?? "",
             isPresented: isShowingDialog,
             titleVisibility: .visible,
             actions: {
                 ForEach(Dialog.allCases.filter { $0 != .inactive }) { dialog in
                     Button(dialog.rawValue, role: dialog == .resetSettings ? .destructive : .cancel) {
                         // action to perform
                     }
                 }
            },
             message: { Text(confirmationDialog?.message ?? "")}
         )
        
        ```
        
    -   `confirmationDialog` 的標題和訊息可以使用 `enum` 的 `rawValue` 或自定義的 `message` 屬性.

**資料儲存 (Data Storage)**

-   **`AppStorage` 的使用：**
    -   使用 `AppStorage` 這個 Property Wrapper 來儲存使用者設定的值到 UserDefaults 中。
    -   `AppStorage` 需要一個 `Key` 來指定儲存的位置，這個 `Key` 必須是 `String`。
    -   為了避免 `Key` 打字錯誤，可以將 `Key` 定義在 `enum` 中。
    -   `AppStorage` 會在啟動時讀取 UserDefaults 中的值，並在值改變時自動儲存.
    -   `AppStorage` 可以設定預設值 (defaultValue)，當 UserDefaults 中沒有值時，會使用這個預設值.
    -   範例程式碼：
        
        ```swift=
        @AppStorage("shouldUseDarkMode") private var shouldUseDarkMode = false
        
        ```
        
-   **自定義 `AppStorage` 的啟動方式 (Initializer)：**
    -   為了讓 `AppStorage` 可以直接使用 `enum` 的 `Key`，可以為 `AppStorage` 加上自定義的啟動方式 (initializer)。
    -   自定義的啟動方式需要指定 `wrappedValue` 的類型 (Value)，並且要符合 `AppStorage` 的類型限制，例如 `Bool`、`String`、`Int`、`Data` 或遵循 `RawRepresentable` 協定的類型。
    -   範例程式碼：
        
        ```swift=
        extension AppStorage {
            init(wrappedValue: Value, _ key: UserDefaults.Key, store: UserDefaults? = nil) where Value == Bool {
                self.init(wrappedValue: wrappedValue, key: key.rawValue, store: store)
            }
           init<Value>(wrappedValue: Value, _ key: UserDefaults.Key, store: UserDefaults? = nil) where Value: RawRepresentable, Value.RawValue == String {
               self.init(wrappedValue: wrappedValue, key: key.rawValue, store: store)
           }
           init<Value>(wrappedValue: Value, _ key: UserDefaults.Key, store: UserDefaults? = nil) where Value: RawRepresentable, Value.RawValue == Int {
                self.init(wrappedValue: wrappedValue, key: key.rawValue, store: store)
            }
        }
        
        @AppStorage(.shouldUseDarkMode) private var shouldUseDarkMode = false
        @AppStorage(.unit) private var selectedUnit: Unit = .gram
        @AppStorage(.startTab) private var startTab: HomeScreen.Tab = .picker
        
        ```
        
    -   **Generic Type 的限制：** 每當有新的 `Value` 類型需要儲存時，都需要新增一個新的啟動方式，這是一個缺點。
    -   可以嘗試自行定義 Property Wrapper 來改進這個問題。
-   **`UserDefaults` Key 的管理：**
    -   使用 `enum` 來管理 `UserDefaults` 的 `Key`，並讓 `enum` 遵循 `String` 的 `RawRepresentable` 協定。
    -   範例程式碼：
        
        ```swift=
        extension UserDefaults {
             enum Key: String {
                 case shouldUseDarkMode
                 case unit
                 case startTab
                 case foodList
             }
         }
        
        ```
        

**修改顏色模式 (Color Scheme)**

-   **`colorScheme` 環境變數：**
    -   可以使用 `colorScheme` 環境變數來設定 App 的顏色模式，例如 `dark` (深色) 或 `light` (淺色)。
    -   在最上層的 View 中讀取 `AppStorage` 中儲存的深色模式設定，並根據這個值來設定 `colorScheme` 環境變數。
    -   範例程式碼：
        
        ```swift=
        @main
        struct YourApp: App {
            @AppStorage(.shouldUseDarkMode) private var shouldUseDarkMode = false
            var body: some Scene {
              WindowGroup {
                    HomeScreen()
                     .environment(\.colorScheme, shouldUseDarkMode ? .dark : .light)
                }
            }
        }
        
        ```
        
-   **`preferredColorScheme` 調整器：**
    -   `preferredColorScheme` 調整器可以設定特定 View 的顏色模式，並將這個設定往上傳遞到最近的 presentation.
    -   當在 sheet 中使用時，它只會影響 sheet 本身的顏色模式，而不會影響到上層的 View。
    -   `preferredColorScheme` 會往上傳遞到最近的 presentation，而不是整個畫面結構.
-   **`NavigationView` 的重要性：**
    -   在 SwiftUI 中，許多元件預設需要在 `NavigationView` (或 `NavigationStack`) 中才能正常運作。
    -   將 View 包在 `NavigationView` (或 `NavigationStack`) 中可以解決 `preferredColorScheme` 無法正常傳遞的問題。
    -   `NavigationView` (或 `NavigationStack`) 會影響畫面的整體結構，背後涉及 UIKit 的 view controller.
-   **Sheet 的顏色模式：**
    -   Sheet 是一個獨立的 presentation，其顏色模式不會被上層的 View 所影響。
    -   可以使用 `preferredColorScheme` 調整器來設定 sheet 的顏色模式，或調整 sheet 的背景顏色。

**其他重點**

-   **View 的結構 (View Structure)：** 使用 Xcode 的 View Debugger 可以查看畫面的結構，了解 View 之間的關係。
-   **`UITransitionView`：** 在 UIKit 中，`UITransitionView` 用來管理 View 的轉場效果，每個 presentation 都會使用一個 `UITransitionView`。
-   **`State` 和 `AppStorage` 的差異：**
    -   `State` 儲存的是 View 內部的狀態，當 View 被釋放時，`State` 的資料也會消失。
    -   `AppStorage` 儲存的是 UserDefaults 中的資料，即使 App 重新啟動，資料也會被保留。
-   **啟動畫面邏輯：**
    -   不要直接使用 `AppStorage` 來管理 `TabView` 的 `selection`，否則會造成預設啟動畫面被覆蓋的問題。
    -   在啟動時讀取 UserDefaults 中的啟動畫面設定，並用這個設定來初始化 `State` 變數。
    -   `AppStorage` 可以在 View 的上一層讀取，然後將值傳給 View 使用，或是在 View 內使用 closure 來讀取，兩者的效果相同，但將 `AppStorage` 放在上一層可以減少程式碼的複雜度.
-   **`preview` 中使用 `AppStorage`:**
    -   `preview` 是一個靜態的計算屬性，無法直接存取 Property Wrapper 的值。
    -   需要將 `preview` 改為 `View`，以便在 `preview` 中存取實例屬性 (instance property).
-   **重置設定的實作：**
    -   在 `confirmationDialog` 的 `action` 中，可以實作重置設定的邏輯，例如刪除 UserDefaults 中儲存的設定。
-   **重置食物列表的實作：**
    -   重置食物列表的功能需要將食物列表的資料從 `AppStorage` 中移除，並恢復為預設值。
    -   `Array` 並不符合 `AppStorage` 預設支援的類型，需要讓 `Array` 遵循 `RawRepresentable` 協定，或使用 `Codable` 協定來實現資料的儲存。

## 編碼與解碼、JSON、AppStorage Custom Type


**編碼 (Encoding) 與解碼 (Decoding) 的基本概念**

-   **編碼 (Encoding)：** 是將一種資料格式轉換成另一種資料格式的過程。
    -   這是因為不同的語言、程式和系統所理解的資料格式不同。
    -   例如，將文字轉換為電腦可以理解的數字，再轉換為二進制格式儲存。
    -   在 Swift 中，編碼是為了將資料轉換成其他程式或系統可以理解的格式。
-   **解碼 (Decoding)：** 是將已編碼的資料轉換回原始資料格式的過程。
    -   目的是將其他程式或系統的資料轉換回自己程式可以使用的格式。
    -   例如，將二進制數字轉換回文字，以便程式可以讀取。
-   **目的差異：**
    -   **編碼**是為了讓其他程式使用。
    -   **解碼**是為了將資料轉換回自己程式可以使用的格式。

**`UserDefaults` 的限制**

-   `UserDefaults` 使用 plist 檔案來儲存資料，因此只支援 plist 支援的資料類型。
-   例如，無法直接儲存自定義的 `Person` 類型，必須先將其轉換為 plist 支援的類型，例如字典 (Dictionary)。
-   將 `Person` 類型轉換為字典的過程就是編碼，而從字典讀回 `Person` 類型的過程就是解碼。
-   **範例程式碼：**
    
    ```swift=
    // 編碼
    let personDict = ["name": "Paul", "age": 30]
    // 解碼
    // 從字典讀取資料並創建 Person 實例
    
    ```
    

**JSON 格式**

-   **JSON (JavaScript Object Notation)：** 是一種通用的編碼格式，用於將 JavaScript 物件轉換為文字格式。
    -   因為具有容易閱讀和解析的特性，被廣泛運用於不同程式語言。
    -   幾乎所有的程式語言都有提供 JSON 轉換的功能。
-   **`JSONEncoder` 和 `JSONDecoder`：**
    -   Swift 提供了 `JSONEncoder` 和 `JSONDecoder` 來進行 JSON 的編碼和解碼。
    -   `JSONEncoder` 將資料轉換為 JSON 格式的文字，並以 Data 形式儲存。
    -   `JSONDecoder` 將 JSON 格式的 Data 轉換回指定的類型。
-   **使用流程：**
    1.  將資料透過 `JSONEncoder` 編碼為 Data。
    2.  將 Data 轉換為 String，以便查看內容。
    3.  將 Data 在不同程式之間傳遞。
    4.  其他程式收到 Data 後，可以將其轉換為文字，並解析出裡面的類型資訊。
    5.  在 Swift 中，透過 `JSONDecoder` 將 Data 解碼為指定類型。
-   **注意事項：**
    -   確保接收到的 JSON 資料格式符合要解碼的類型。
    -   如果資料格式不符，會發生錯誤。

**`Codable` 協定**

-   **`Codable` 協定：** 是一個別名 (type alias)，代表 `Decodable` 和 `Encodable` 這兩個協定。
    -   `Decodable` 代表解碼能力。
    -   `Encodable` 代表編碼能力。
-   **自動遵循 `Codable`：**
    -   當一個類型 (Type) 的所有屬性 (properties) 都遵循 `Codable` 時，這個類型就可以自動遵循 `Codable`。
    -   Swift 內建的原始類型 (primitive types) 幾乎都是 `Codable` 的，例如 `String`、數字 (Number)、布林值 (Boolean)、字典 (Dictionary) 和陣列 (Array)。
-   **如何使用 `Codable`：**
    1.  讓你的類型遵循 `Codable` 協定。
    2.  使用 `JSONEncoder` 編碼資料。
    3.  使用 `JSONDecoder` 解碼資料。
-   **`Codable` 的運作方式：**
    -   編碼時，需要告訴編碼器哪些資料需要被編碼進去，以及對應的格式。
    -   解碼時，需要告訴解碼器從哪裡讀取資料，以及如何轉換資料。

**`RawRepresentable` 協定與 `Codable` 的結合**

-   **`RawRepresentable` 協定：** 讓一個類型可以和另一個類型之間進行來回轉換。
    -   為了在 `AppStorage` 中儲存自定義類型，可以讓自定義類型遵循 `RawRepresentable` 協定，並將其 `RawValue` 定義為 `String` 或 `Int`。
    -   可以利用 `Codable` 將自定義類型轉換為 `String` 格式，以便儲存到 `AppStorage` 中。
-   **實作 `RawRepresentable`：**
    -   需要定義一個產生 `rawValue` 的方法，以及一個從 `rawValue` 啟動 (initializer) 的方法。
    -   **產生 `rawValue`：** 使用 `JSONEncoder` 將自己編碼為 Data，再將 Data 轉換為 String。
    -   **從 `rawValue` 啟動：** 使用 `JSONDecoder` 將 String 轉換為 Data，再將 Data 解碼為自己的類型。
-   **無限迴圈的問題：**
    -   Swift 內建的 extension 會自動使用 `rawValue` 中的值做編碼，導致如果 `rawValue` 的產生方式是透過編碼自己，就會產生無限迴圈。
    -   **解決方案：** 需要自己定義編碼和解碼的方式，覆蓋掉 Swift 預設的 extension。

**Xcode 自動生成 `Codable` 程式碼**

-   **自動生成：** Xcode 14 可以自動生成預設的編碼和解碼程式碼。
    -   在類型上按下 command + 左鍵，選擇 "加入明確的 Codable 設計 (Add explicit Codable conformance)"。
-   **生成程式碼的內容：**
    -   宣告一組用於儲存資料的 Key。
    -   在 `Decodable` 的啟動方法中，指定每個 Key 裡面的資料類型和要放入的屬性。
    -   在 `Encodable` 的方法中，指定要編碼的資料和要儲存的 Key。
-   **注意事項：**
    -   確保所有屬性類型都必須是 `Codable` 的。
    -   生成的 Key 預設是使用屬性的名稱。
-   **`Codable` 自動生成問題：**
    -   有時直接點擊 "加入明確的 Codable 設計 (Add explicit Codable conformance)" 只會跳出 Key 給你，需要先將 `Codable` 移到 `struct` 上面，再重新點擊一次才會正常顯示。

**在 `AppStorage` 中使用 `Codable`**

-   **結合 `Codable` 和 `RawRepresentable`：** 使用 `Codable` 產生 `String` 格式的 `rawValue`，讓自定義類型可以在 `AppStorage` 中儲存。
-   **實作範例：**
    -   讓 `Food` 類型遵循 `Codable` 協定，以便使用 `JSONEncoder` 和 `JSONDecoder` 進行編碼和解碼。
    -   讓 `[Food]` 類型遵循 `RawRepresentable` 協定，並將其 `RawValue` 定義為 `String`。
    -   實作產生 `rawValue` 的方法，將 `[Food]` 編碼為 JSON 格式的 String。
    -   實作從 `rawValue` 啟動的方法，將 JSON 格式的 String 解碼為 `[Food]`。
-   **Generic Type 的應用：**
    -   可以將 `Array` 的 `RawRepresentable` 實作改為更通用的方式，讓任何 `Element` 是 `Codable` 的 `Array` 都可以使用。
-   **程式碼範例：**
    
    ```swift=
    extension Array: RawRepresentable where Element: Codable {
      public init?(rawValue: String) {
          guard let data = rawValue.data(using: .utf8) else {
              return nil
          }
          guard let array = try? JSONDecoder().decode([Element].self, from: data) else {
              return nil
          }
          self = array
      }
    
      public var rawValue: String {
           guard let data = try? JSONEncoder().encode(self) else {
                return ""
           }
           return String(data: data, encoding: .utf8) ?? ""
      }
    }
    
    ```
    

**總結**

-   **編碼與解碼**是資料轉換的基礎，讓不同系統可以互相溝通。
-   **JSON** 是一種通用的編碼格式，易於閱讀和解析。
-   **`Codable`** 協定讓 Swift 類型可以自動進行編碼和解碼。
-   **`RawRepresentable`** 協定讓類型可以與其他類型之間進行轉換，方便在 `AppStorage` 中儲存。
-   **Xcode 自動生成** `Codable` 程式碼可以簡化開發流程。
