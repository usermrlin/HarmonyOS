import UserDialog from '../view/welcome/CustomDialog'
import common from '@ohos.app.ability.common'
import preferenceUtil from '../common/utils/PreferenceUtil'
import router from '@ohos.router'
@Extend(Text) function TextStyle(opacity: number,fontSize: number=10){
  .fontSize(fontSize)
  .opacity(opacity)
  .fontColor(Color.White)
}
const PREF_KEY = 'userPrivacykey'
@Entry
@Component
struct WlecomePage {
  context = getContext(this) as common.UIAbilityContext
  controller:CustomDialogController = new CustomDialogController({
    builder:UserDialog({
      confirm:()=> this.onConfirm(),
      cancel:() => this.exitApp()
    })

  })
 async aboutToAppear(){
    // 1.加载首先项
    let isAgree = await preferenceUtil.getPreferenceValue(PREF_KEY,false)
    // 2.判断是否同意
   if(isAgree) {
   //   同意跳转到首页
    this.jumpToIndex()
   } else {
   //   不同意，弹窗
     this.controller.open()
   }
  }

  jumpToIndex(){
    setTimeout(()=>{
      router.replaceUrl({
        url:'pages/Index'
      })
    },1000)

  }
  onConfirm(){
    preferenceUtil.putPreferenceValue(PREF_KEY,true)
    this.jumpToIndex()
  }
  exitApp(){
    this.context.terminateSelf()
  }
  build() {
      Column({space:10}) {
        Row(){
          Image($r('app.media.home_slogan')).width(260)
        }
        .layoutWeight(1)
        Image($r('app.media.home_logo')).width(150)
        Row(){
          Text('黑马健康支持').TextStyle(0.8,12)
          Text('IPv6')
            .TextStyle(0.8)
            .border({style:BorderStyle.Solid,width: 1,color:Color.White,radius:15})
            .padding({left:5,right:5})
          Text('网络').TextStyle(0.8)
        }
        Text(`'减更多'指黑马健康App希望通过软件工具的形式，帮助更多用户实现身材管理`)
          .TextStyle(0.6)
        Text('浙ICP备0000000号-36D')
          .TextStyle(0.4)
          .margin({bottom:35})
      }
      .width('100%')
      .height('100%')
      .backgroundColor($r('app.color.welcome_page_background'))
  }
}function opacity(opacity: any) {
throw new Error('Function not implemented.')
}
