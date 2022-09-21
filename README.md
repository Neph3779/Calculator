**프로젝트명: 계산기**

**프로젝트 설명:** 아이폰의 기본 어플인 계산기를 실제와 유사하게 동작하도록 만든 어플리케이션. 아이폰 계산기에는 없는 2진법 계산기가 추가로 구현되어 있음.

**프로젝트 기간: 2021/03/22 ~ 2021/04/02 (약 2주)**



**작동화면**

<img src="https://raw.githubusercontent.com/Neph3779/Blog-Image/forUpload/img/20220921212924.gif" alt="계산기 프로젝트 Step3" style="zoom:67%;" />



## 주요 학습 내용

- Protocol의 제작과 활용
- Cusom UI 객체들의 활용
- CALayer 속성을 이용하여 view에 추가적인 효과 부여에 대해 학습
- 복잡한 로직을 구현하기 위해 객체들의 기능을 분리하고 모듈화
- 일관성 있는 코드 컨벤션을 지키기 위한 SwiftLint의 적용 및 사용
- Generic Type에 대한 학습과 이를 활용한 Stack 제작
  - Stack을 활용하여 Postfix 연산을 구현
- 2진법 연산에 필요한 연산기호들과 연산과정에 대해 학습
- 소수점 연산시 연산결과의 부정확성(IEEE754 부동소수점)에 대해 이해
- UML에 대해 학습
- Unit Test를 통한 로직 검증
- final 키워드 학습



### 계산기 로직 플로우차트

<img src="https://raw.githubusercontent.com/Neph3779/Blog-Image/forUpload/img/20220921212756.png" alt="계산기 프로젝트 로직" style="zoom: 67%;" />



## 주요 피드백과 개선내역

**Step1 PR 링크:** https://github.com/yagom-academy/ios-calculator-app/pull/18

**Step2 PR 링크:** https://github.com/yagom-academy/ios-calculator-app/pull/24

**Step3 PR 링크:** https://github.com/yagom-academy/ios-calculator-app/pull/28



> 피드백 1: 표현의 차이긴 한데 if문에서 검사하는 로직자체를 반환하는 표현할 수도 있겠네요 참고하세용 !

조건식 자체가 Bool값이기 때문에 이를 바로 반환할 수 있다는 것을 알게되었다. 피드백을 통해 더 간결한 코드를 작성할 수 있었다.

<br/> 

> 피드백 2: 이미 정해져있는 formatter를 매번 메서드 호출 시 마다 생성해야할까요? 어떻게 비용을 줄일 수 있을까요!

NumberFormatter 인스턴스를 사용시마다 만들어서 쓰고 있는 것에 대한 피드백이었다.

 항상 class 내에서 사용가능한 프로퍼티로 제작한다면 프로퍼티의 수 증가로 인한 관리대상 증가, 가독성 저하를 불러올 것이고, 반대로 매번 메서드 내 지역변수로 선언한다면 불필요한 코드가 길어지고 모든 foramtter에 같은 변화를 주어야 할때 모든 지역변수를 수정해야 하기에 불편할 것이라 생각했다. 

이번 경우에는 formatter가 하는일이 고정되어 있고 여러 곳에서 사용하므로 하나의 프로퍼티로 만들어 사용하는 방안을 선택하는게 좋다고 판단했다.

<br/> 

> 피드백 3: 어떤 버튼은 super를 호출하고, 어떤 버튼은 super를 호출하지 않고 있네요.

override한 메서드는 super 클래스의 원래 메서드를 호출한 뒤에 추가적인 구현내용을 적는 것이 바람직하다는 것을 공부를 통해 알게 되었다. override했다는 것은 super 클래스가 구현해놓은 메서드의 기능을 임의로 바꾸는 것이므로 기존에 의도한 것과 다르게 동작할 염려가 있으니 super 클래스가 구현해놓은 것을 먼저 호출하는 것이 바람직하다. (만약 그 메서드가 아무 역할을 하지 않더라도)



