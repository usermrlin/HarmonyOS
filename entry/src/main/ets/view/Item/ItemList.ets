import { CommonConstants } from '../../common/constants/CommonConstants'

@Component
export default struct ItemLIst {
  build() {
    Tabs() {
      TabContent() {
        this.TabContentBuilder()
      }
      .tabBar('全部')

      TabContent() {
        this.TabContentBuilder()
      }
      .tabBar('肉蛋奶')

      TabContent() {
        this.TabContentBuilder()
      }
      .tabBar('主食')
    }
    .width(CommonConstants.THOUSANDTH_940)
    .height('100%')
  }

  @Builder TabContentBuilder() {
    List({ space: CommonConstants.SPACE_6 }) {
      ForEach([1, 2, 3, 4, 5], (item) => {
        ListItem() {
          Row({ space: CommonConstants.SPACE_6 }) {
            Image($r('app.media.milk')).width(50)
            Column({ space: CommonConstants.SPACE_4 }) {
              Text('全麦吐司').fontWeight(CommonConstants.FONT_WEIGHT_500)
              Text('91千卡/1片').fontSize(14).fontColor($r('app.color.light_gray'))
            }

            Blank()
            Image($r('app.media.ic_public_add_norm_filled'))
              .width(18)
              .fillColor($r('app.color.primary_color'))
          }
          .width('100%')
          .padding(CommonConstants.SPACE_6)
        }
      })
    }
    .width('100%')
    .height('100%')
  }
}