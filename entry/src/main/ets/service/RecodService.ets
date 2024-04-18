import RecordPO from '../common/bean/RecordPO'
import dateUtil from '../common/utils/DateUtil'
import itemModel from '../model/ItemModel'
import RecordModel from '../model/RecordModel'
import { RecordTypeEnum, RecordTypes } from '../model/RecordTypeModel'
import GroupInfo from '../viewmodel/GroupInfo'
import RecordType from '../viewmodel/RecordType'
import RecordVO from '../viewmodel/RecordVO'
import StatsInfo from '../viewmodel/StatsInfo'

class RecordService {
  insert(typeId: number, itemId: number, amount: number) {
    // 获取时间
    let createTime = (AppStorage.Get('selectedDate') || dateUtil.beginTimeOfDay(new Date())) as number
    // 新增
    return RecordModel.insert({
      typeId,
      itemId,
      amount,
      createTime,
      id: 0
    })
  }

  deleteById(id: number) {
    return RecordModel.deleteById(id)
  }

  async queryRecordByDate(date: number): Promise<RecordVO[]> {
    // 查询数据库
    let rps = await RecordModel.listByDate(date)
    return rps.map(rp => {
      let rv = { id: rp.id, typeId: rp.typeId, amount: rp.amount } as RecordVO
      rv.recordItem = itemModel.getById(rp.itemId, rp.typeId !== RecordTypeEnum.WORKOUT)
      rv.calorie = rp.amount * rv.recordItem.calorie
      return rv
    })
  }

  calculateStatsInfo(records: RecordVO[]): StatsInfo {
    let info = new StatsInfo()
    if (!records || records.length <= 0) {
      records.forEach(r => {
        if (r.typeId === RecordTypeEnum.WORKOUT) {
          info.expend += r.calorie
        } else {
          info.intake += r.calorie
          info.carbon += r.recordItem.carbon
          info.protein += r.recordItem.protein
          info.fat += r.recordItem.fat
        }
      })
      return info
    }
  }

  calculateGroupInfo(records: RecordVO[]): GroupInfo<RecordType, RecordVO>[] {
    let groups = RecordTypes.map(recordType => new GroupInfo(recordType, []))
    if (!records || records.length <= 0) {
      return groups
    }
    records.forEach(record => {
      groups[record.typeId].items.push(record)
      groups[record.typeId].calorie += record.calorie
    })
    return groups
  }
}

let recordService = new RecordService()

export default recordService as RecordService