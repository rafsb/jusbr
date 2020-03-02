echo -e "CLARO \n"

file="claro_internet_fixa.csv"
folder="fabiovar_claro_internet_fixa"
grepvar1=" claro s"
grepvar2="(?=.*internet fixa)(?=.*recurso)|(?=.*internet fixa)(?=.*apela[çc][aã]o)"
echo -e "\n"$folder
mkdir -p $folder; for i in $(ls var | grep "claro" | grep "InternetFixa"); do cp var/$i $folder/$i; done;
php filter.php $folder tmp/$file "$grepvar1" "$grepvar2"

file="claro_internet_movel.csv"
folder="fabiovar_claro_internet_movel"
grepvar1=" claro s"
grepvar2="(?=.*internet m[oó]vel)(?=.*recurso)|(?=.*internet m[oó]vel)(?=.*apela[çc][aã]o)"
echo -e "\n"$folder
mkdir -p $folder; for i in $(ls var | grep "claro" | grep "Mvel"); do cp var/$i $folder/$i; done;
php filter.php $folder tmp/$file "$grepvar1" "$grepvar2"

file="claro_pacote_servicos.csv"
folder="fabiovar_claro_pacote_servicos"
grepvar1=" claro s"
grepvar2="(?=.*pacote servi[çc]o[s])(?=.*recurso)|(?=.*pacote servi[çc]o[s])(?=.*apela[çc][aã]o)"
echo -e "\n"$folder
mkdir -p $folder; for i in $(ls var | grep "claro" | grep "Pacote"); do cp var/$i $folder/$i; done;
php filter.php $folder tmp/$file "$grepvar1" "$grepvar2"

file="claro_telefonia_fixa.csv"
folder="fabiovar_claro_telefonia_fixa"
grepvar1=" claro s"
grepvar2="(?=.*internet fixa)(?=.*recurso)|(?=.*internet fixa)(?=.*apela[çc][aã]o)"
echo -e "\n"$folder
mkdir -p $folder; for i in $(ls var | grep "claro" | grep "TelefoniaFixa"); do cp var/$i $folder/$i; done;
php filter.php $folder tmp/$file "$grepvar1" "$grepvar2"

file="claro_pos_pago.csv"
folder="fabiovar_claro_pos_pago"
grepvar1=" claro s"
grepvar2="(?=.*p[oó]s pago)(?=.*recurso)|(?=.*p[oó]s pago)(?=.*apela[çc][aã]o)"
echo -e "\n"$folder
mkdir -p $folder; for i in $(ls var | grep "claro" | grep "PsPago"); do cp var/$i $folder/$i; done;
php filter.php $folder tmp/$file "$grepvar1" "$grepvar2"

file="claro_pre_pago.csv"
folder="fabiovar_claro_pre_pago"
grepvar1=" claro s"
grepvar2="(?=.*pr[eé] pago)(?=.*recurso)|(?=.*pr[eé] pago)(?=.*apela[çc][aã]o)"
echo -e "\n"$folder
mkdir -p $folder; for i in $(ls var | grep "claro" | grep "PrPago"); do cp var/$i $folder/$i; done;
php filter.php $folder tmp/$file "$grepvar1" "$grepvar2"

file="claro_tv_por_assinatura.csv"
folder="fabiovar_claro_tv_por_assinatura"
grepvar1=" claro s"
grepvar2="(?=.*tv)(?=.*assinatura)(?=.*recurso)|(?=.*tv)(?=.*assinatura)(?=.*apela[çc][aã]o)"
echo -e "\n"$folder
mkdir -p $folder; for i in $(ls var | grep "claro" | grep "Assinatura"); do cp var/$i $folder/$i; done;
php filter.php $folder tmp/$file "$grepvar1" "$grepvar2"

file="claro_controle.csv"
folder="fabiovar_claro_controle"
grepvar1=" claro s"
grepvar2="(?=.*controle)(?=.*recurso)|(?=.*controle)(?=.*apela[çc][aã]o)"
echo -e "\n"$folder
mkdir -p $folder; for i in $(ls var | grep "claro" | grep "Controle"); do cp var/$i $folder/$i; done;
php filter.php $folder tmp/$file "$grepvar1" "$grepvar2"

file="claro_banda_larga.csv"
folder="fabiovar_claro_banda_larga"
grepvar1=" claro s"
grepvar2="(?=.*banda larga)(?=.*recurso)|(?=.*banda larga)(?=.*apela[çc][aã]o)"
echo -e "\n"$folder
mkdir -p $folder; for i in $(ls var | grep "claro" | grep "Banda"); do cp var/$i $folder/$i; done;
php filter.php $folder tmp/$file "$grepvar1" "$grepvar2"