select distinct sdh.shidat_0
              , sdh.sdhnum_0
              , ori.SDHNUM_0                                                  as originBL
              , ori.BPCORD_0
              , ori.BPINAM_0
              , stk.PALNUM_0                                                  as SSCC
              , sdh.bptnum_0
              , ori.sohnum_0
              , ori.ysohnumori_0                                              as originSO
              , count(distinct stk.PALNUM_0) over (partition by sdh.sdhnum_0) as nbSSCC
from sdelivery sdh,
     STOPREH sth,
     STOPRED stp,
     STOALL sta,
     STOCK stk,
     (select distinct a.sohnum_0,
                      a.ysohnumori_0,
                      c.BPINAM_0,
                      b.BPCORD_0,
                      d.SDHNUM_0
      from sorderq a,
           sorderq b,
           SORDER c,
           SDELIVERY d
      where a.ysohnumori_0 = b.sohnum_0
        and a.ysoplinori_0 = b.soplin_0
        and a.YSOHNUMORI_0 = c.SOHNUM_0
        and a.YSOHNUMORI_0 = d.SOHNUM_0
        and d.CFMFLG_0 < 2
     ) ori
where sdh.SDHNUM_0 = sth.SDHNUM_0
  and sth.PRHNUM_0 = stp.PRHNUM_0
  and sta.VCRNUM_0 = sdh.SDHNUM_0
  and stk.STOCOU_0 = sta.STOCOU_0
  and ori.SOHNUM_0 = sdh.SOHNUM_0
  and sdh.bptnum_0 = 'ZIEGLER'
  and sdh.CFMFLG_0 < 2

order by sdh.SDHNUM_0