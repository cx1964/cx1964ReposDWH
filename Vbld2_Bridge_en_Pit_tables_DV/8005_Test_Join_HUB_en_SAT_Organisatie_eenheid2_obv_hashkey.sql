-- File: 8005_Test_Join_HUB_en_SAT_Organisatie_eenheid2_obv_hashkey
-- Functie: join H_Organisatie_Eenheid2 aan S_Organisatie_Eenheid2 obv H_Organisatie_Eenheid2Hashkey

select ho.*
      ,so.*
from [TestIntegrationDB2].dbo.H_Organisatie_Eenheid2 ho
inner join [TestIntegrationDB2].dbo.S_Organisatie_Eenheid2 so
      on so.H_Organisatie_Eenheid2Hashkey = ho.H_Organisatie_Eenheid2Hashkey -- join op hashkey waarde met varchar columns

      -- werkt