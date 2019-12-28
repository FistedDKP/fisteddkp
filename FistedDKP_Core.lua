local _, fisted = ...

function FistedDKP:OnEnable()
    print("FistedDKP Loading")
    print(fisted.version)

    FistedDKP_Communication:CommEnable()
 end