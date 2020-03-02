echo -e "CLARO \n"

file="claro_internet_fixa.csv"
folder="fabiovar_claro_internet_fixa"
grepvar1=" claro s"
grepvar2="internet fixa"
echo -e "\n"$folder
mkdir -p $folder; for i in $(ls var | grep "claro" | grep "InternetFixa"); do cp var/$i $folder/$i; done;
php filter.php $folder tmp/$file "$grepvar1" "$grepvar2"

file="claro_internet_movel.csv"
folder="fabiovar_claro_internet_movel"
grepvar1=" claro s"
grepvar2="internet movel"
echo -e "\n"$folder
mkdir -p $folder; for i in $(ls var | grep "claro" | grep "Mvel"); do cp var/$i $folder/$i; done;
php filter.php $folder tmp/$file "$grepvar1" "$grepvar2"

file="claro_pacote_servicos.csv"
folder="fabiovar_claro_pacote_servicos"
grepvar1=" claro s"
grepvar2="pacote servi"
echo -e "\n"$folder
mkdir -p $folder; for i in $(ls var | grep "claro" | grep "Pacote"); do cp var/$i $folder/$i; done;
php filter.php $folder tmp/$file "$grepvar1" "$grepvar2"

file="claro_telefonia_fixa.csv"
folder="fabiovar_claro_telefonia_fixa"
grepvar1=" claro s"
grepvar2="telefonia fixa"
echo -e "\n"$folder
mkdir -p $folder; for i in $(ls var | grep "claro" | grep "TelefoniaFixa"); do cp var/$i $folder/$i; done;
php filter.php $folder tmp/$file "$grepvar1" "$grepvar2"

file="claro_pos_pago.csv"
folder="fabiovar_claro_pos_pago"
grepvar1=" claro s"
grepvar2="pos pago"
echo -e "\n"$folder
mkdir -p $folder; for i in $(ls var | grep "claro" | grep "PsPago"); do cp var/$i $folder/$i; done;
php filter.php $folder tmp/$file "$grepvar1" "$grepvar2"

file="claro_pre_pago.csv"
folder="fabiovar_claro_pre_pago"
grepvar1=" claro s"
grepvar2="pre pago"
echo -e "\n"$folder
mkdir -p $folder; for i in $(ls var | grep "claro" | grep "PrPago"); do cp var/$i $folder/$i; done;
php filter.php $folder tmp/$file "$grepvar1" "$grepvar2"

file="claro_tv_por_assinatura.csv"
folder="fabiovar_claro_tv_por_assinatura"
grepvar1=" claro s"
grepvar2="tv por assinatura"
echo -e "\n"$folder
mkdir -p $folder; for i in $(ls var | grep "claro" | grep "Assinatura"); do cp var/$i $folder/$i; done;
php filter.php $folder tmp/$file "$grepvar1" "$grepvar2"

file="claro_controle.csv"
folder="fabiovar_claro_controle"
grepvar1=" claro s"
grepvar2="controle"
echo -e "\n"$folder
mkdir -p $folder; for i in $(ls var | grep "claro" | grep "Controle"); do cp var/$i $folder/$i; done;
php filter.php $folder tmp/$file "$grepvar1" "$grepvar2"

file="claro_banda_larga.csv"
folder="fabiovar_claro_banda_larga"
grepvar1=" claro s"
grepvar2="banda larga"
echo -e "\n"$folder
mkdir -p $folder; for i in $(ls var | grep "claro" | grep "Banda"); do cp var/$i $folder/$i; done;
php filter.php $folder tmp/$file "$grepvar1" "$grepvar2"