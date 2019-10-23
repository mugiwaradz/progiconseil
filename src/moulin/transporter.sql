select distinct sdh.shidat_0
              , sdh.sdhnum_0
              , stp.PRHNUM_0
              , ori.BPINAM_0
              , stk.PALNUM_0
              , sdh.bptnum_0
              , ori.sohnum_0
              , ori.ysohnumori_0
from sdelivery sdh,
     STOPREH sth,
     STOPRED stp,
     STOALL sta,
     STOCK stk,
     (select distinct a.sohnum_0,
                      a.ysohnumori_0,
                      c.BPINAM_0
      from sorderq a,
           sorderq b,
           SORDER c
      where a.ysohnumori_0 = b.sohnum_0
        and a.ysoplinori_0 = b.soplin_0
        and a.YSOHNUMORI_0 = c.SOHNUM_0
     ) ori
where sdh.SDHNUM_0 = sth.SDHNUM_0
  and sth.PRHNUM_0 = stp.PRHNUM_0
  and sta.VCRNUM_0 = sdh.SDHNUM_0
  and stk.STOCOU_0 = sta.STOCOU_0
  and ori.SOHNUM_0 = sdh.SOHNUM_0
  and sdh.bptnum_0 = 'ZIEGLER'
  and sdh.CFMFLG_0 < 2
order by sdh.bptnum_0;