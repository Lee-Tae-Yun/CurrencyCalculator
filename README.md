# Currency Calculator App

**환율 계산기 앱**  
실시간 환율 정보를 조회하고, 즐겨찾기 기능을 통해 자주 사용하는 통화를 빠르게 확인할 수 있는 iOS 앱입니다.


## 🧩 주요 기능

- ✅ 실시간 환율 정보 조회
- 📌 즐겨찾기 추가 및 제거 (CoreData에 영구 저장)
- 🔍 통화명 / 코드 검색 기능
- 📊 선택한 통화의 환율 계산 기능
- 🎨 UIKit + MVVM 아키텍처 기반 UI 구현

---

## 📁 프로젝트 구조
CurrencyCalculatorApp/  
├── Application/  
│   ├── AppDelegate.swift  
│   ├── SceneDelegate.swift  
│   ├── Assets.xcassets  
│   ├── Info.plist  
│   └── LaunchScreen.storyboard  
├── CoreData/  
│   └── CurrencyCalculatorApp.xcdatamodeld  
├── Model/  
│   ├── CoreData/  
│   │   ├── FavoriteCurrency+CoreDataClass.swift  
│   │   └── FavoriteCurrency+Properties.swift  
│   ├── CounteyModel.swift  
│   └── CurrencyModel.swift  
├── Network/  
│   └── CurrencyService.swift  
├── Protocol/  
│   └── ViewModelProtocol.swift  
├── View/  
│   ├── CalculatorView/  
│   │   ├── CalculatorView.swift  
│   │   └── CalculatorViewController.swift  
│   └── CurrencyView/  
│       ├── CurrencyTableViewCell.swift  
│       ├── CurrencyView.swift  
│       └── CurrencyViewController.swift  
├── ViewModel/  
│   ├── CalculatorViewModel.swift  
│   └── CurrencyViewModel.swift  

## 📸 스크린샷

<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 16 Pro - 2025-07-14 at 11 08 53" src="https://github.com/user-attachments/assets/7d5066de-ab78-47c7-95cd-5ad49688857f" />

<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 16 Pro - 2025-07-14 at 11 09 14" src="https://github.com/user-attachments/assets/19781474-3edd-450f-a882-1a26acd6a52f" />


