select itmref,
       itmdes,
       repture,
       qtyuom_0,
       zdateconfirm_0,
       nbCommande
from (select itmref,
             itmdes,
             repture,
             poq.qtyuom_0,
             poq.zdateconfirm_0 as zdateconfirm_0
      from (select itv.itmref_0                                 as itmref,
                   itm.YITMDES_0                                as itmdes,
                   (itv.physto_0 + itv.ctlsto_0 - itv.salsto_0) as repture
            from itmmvt itv,
                 ITMMASTER itm
            where (itv.physto_0 + itv.ctlsto_0 - itv.salsto_0) < 0
              and itv.STOFCY_0 = %1%
              and itv.ITMREF_0 = itm.ITMREF_0(+)) itv2,
           porderq poq
      where itmref = poq.itmref_0(+)
        and poq.lincleflg_0 = 1
        and poq.POHFCY_0 = %1%
      Union all
      select itmref,
             itmdes,
             repture,
             poq.qtyuom_0,
             poq.ORDDAT_0 as zdateconfirm_0
      from (select itv.itmref_0                                 as itmref,
                   itm.YITMDES_0                                as itmdes,
                   (itv.physto_0 + itv.ctlsto_0 - itv.salsto_0) as repture,
                   0                                            as qtyuom_0,
                   null                                         as zdateconfirm_0
            from itmmvt itv,
                 ITMMASTER itm
            where (itv.physto_0 + itv.ctlsto_0 - itv.salsto_0) < 0
              and itv.STOFCY_0 = %1%
              and itv.ITMREF_0 = itm.ITMREF_0(+)) itv2,
           (select * from porderq where lincleflg_0 = 1 and POHFCY_0 = %1%) poq
      where itmref = poq.itmref_0(+)
        and poq.pohnum_0 is null
      order by 1 desc) al,
     (select count(SOHNUM_0) as nbCommande, ITMREF_0
      from SORDERQ soq
      where soq.SOQSTA_0 < 3
      group by ITMREF_0) so
where so.ITMREF_0 = al.itmref
order by 1 desc;