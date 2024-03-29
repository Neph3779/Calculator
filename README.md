**프로젝트명: 계산기**

**프로젝트 설명:** 아이폰의 기본 어플인 계산기를 실제와 유사하게 동작하도록 만든 어플리케이션. 아이폰 계산기에는 없는 2진법 계산기가 추가로 구현되어 있음.

**프로젝트 기간: 2021/03/22 ~ 2021/04/02 (약 2주)**

**프로젝트 진행인원: 3인**

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



## 프로젝트를 진행하며 했던 고민들

#### 10진수 계산기와 2진수 계산기를 하나로 합칠수는 없을까?

10진수 계산기와 2진수 계산기는 얼핏보기엔 비슷한 인터페이스의 메서드를 많이 가지고 있다.

하지만 10진수의 계산결과 포맷팅 로직과 2진수의 계산결과 포맷팅 로직이 다르며 둘을 합치는것이 큰 이점을 주지 않을 것이라 판단하였다.



#### type method v.s. instance method

완성된 코드에서 채택한 것은 static을 통한 type method의 사용이다. 계산기 사용시마다 instance를 만들지 않아도 되므로 관리하는 측면에서 더 효율적이지만, 피연산자들을 프로퍼티로 저장할 수 없기 때문에 모든 메서드마다 동일한 로직이 들어가게 되었다.

```swift
static func add(firstNumber: String, secondNumber: String) -> String {
    do {
        let first = try formatInput(firstNumber)
        let second = try formatInput(secondNumber)
        let result = first + second
        return try formatResult(of: result)
    } catch {
        return "ERROR"
    }
}
    
static func subtract(firstNumber: String, secondNumber: String) -> String {
    do {
        let first = try formatInput(firstNumber)
        let second = try formatInput(secondNumber)
        let result = first - second
        return try formatResult(of: result)
    } catch {
        return "ERROR"
    }
}
```

(위의 코드처럼 first, second라는 첫번째 피연산자와 두번째 피연산자를 Double로 바꿔주는 로직이 중복되는 것을 볼 수 있다.)

이를 해결해보기 위해 고민을 해보았지만 Calculator 클래스를 사용하는 입장의 편의성을 위해서 이대로 두는 것이 낫다는 결론을 내렸다. 



#### Error 발생시에 어떻게 처리할 것인가

사용자가 누를 수 있는 버튼이 정해져있고, 오직 숫자값만이 입력으로 들어오는 것이 보장되어있으니, String -> Double의 전환시에 error catch를 하지 않아도 되지 않느냐? 라는 의견이 있었고,

반대로 그것은 클라이언트 (계산기 로직을 사용하는) 쪽에서 케어를 해줘야 할 부분이 늘어나는 것이므로 계산기 클래스를 구현하는 입장에서는 번거롭더라도 strict하게 가는 것이 맞다. 와 같은 의견이 있었다.

둘 모두 일리있는 의견이었지만, 우리 팀이 선택한 의견은 후자였으며 이로 인해 input과 output을 formatting 하는 로직에서 error throwing이 발생했다.
