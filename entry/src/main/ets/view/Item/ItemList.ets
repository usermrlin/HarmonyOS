import { CommonConstants } from '../../common/constants/CommonConstants'
import ItemModel from '../../model/ItemModel'
import GroupInfo from '../../viewmodel/GroupInfo'
import ItemCategory from '../../viewmodel/ItemCategory'
import RecordItem from '../../viewmodel/RecordItem'

@Component
export default struct ItemLIst {
  showPanel: (item: RecordItem) => void
  @State isFood: boolean = true
  data = [
    new GroupInfo(new ItemCategory(0, '主食'), []),
    new GroupInfo(new ItemCategory(1, '果蔬'), []),
    new GroupInfo(new ItemCategory(2, '肉蛋白'), []),
    new GroupInfo(new ItemCategory(3, '坚果'), []),
    new GroupInfo(new ItemCategory(4, '其他'), [])
  ]

  build() {
    Tabs() {
      TabContent() {
        this.TabContentBuilder(ItemModel.list(this.isFood))
      }
      .tabBar('全部')

      ForEach(ItemModel.listItemGroupByCategory(this.isFood), (group: GroupInfo) => {
        TabContent() {
          this.TabContentBuilder(group.items)
        }
        .tabBar(group.type.name)
      })

    }
    .width(CommonConstants.THOUSANDTH_940)
    .height('100%')
    .barMode(BarMode.Scrollable)
  }

  @Builder TabContentBuilder(items: RecordItem[]) {
    List({ space: CommonConstants.SPACE_6 }) {
      ForEach(items, (item: RecordItem) => {
        ListItem() {
          Row({ space: CommonConstants.SPACE_6 }) {
            Image(item.image).width(50)
            Column({ space: CommonConstants.SPACE_4 }) {
              Text(item.name).fontWeight(CommonConstants.FONT_WEIGHT_500)
              Text(`${item.calorie}千卡/${item.unit}`).fontSize(14).fontColor($r('app.color.light_gray'))
            }

            Blank()
            Image($r('app.media.ic_public_add_norm_filled'))
              .width(18)
              .fillColor($r('app.color.primary_color'))
          }
          .width('100%')
          .padding(CommonConstants.SPACE_6)
        }
        .onClick(() => this.showPanel(item))
      })
    }
    .width('100%')
    .height('100%')
  }
}