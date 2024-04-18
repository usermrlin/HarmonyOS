import { CommonConstants } from '../common/constants/CommonConstants'
import router from '@ohos.router'
import ItemList from '../view/Item/ItemList'
import ItemPanelHeader from '../view/Item/ItemPanelHeader'
import ItemCard from '../view/Item/ItemCard'

@Entry
@Component
struct ItemIndex {
  @State amount: number = 1
  @State showPanel: boolean = false

  onPanleShow() {
    this.showPanel = true
  }

  build() {

    Column() {
      //   头部导航
      this.Header()
      //   列表
      ItemList({ showPanel: this.onPanleShow.bind(this) })
        .layoutWeight(1)
      //   底部面板
      Panel(this.showPanel) {
        //   顶部日期
        ItemPanelHeader()
        //   记录项卡片
        ItemCard({ amount: this.amount })
        //   数字键盘
        //   按钮
      }
      .mode(PanelMode.Full)
      .dragBar(false)
      .backgroundMask($r('app.color.light_gray'))
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
  }

  @Builder Header() {
    Row() {
      Image($r('app.media.ic_public_back'))
        .width(24)
        .onClick(() => router.back())
      Blank()
      Text('早餐').fontSize(18).fontWeight(CommonConstants.FONT_WEIGHT_600)
    }
    .width((CommonConstants.THOUSANDTH_940))
    .height(32)
  }
}