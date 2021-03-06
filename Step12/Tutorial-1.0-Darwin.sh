#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --version         print cmake installer version
  --prefix=dir      directory in which to install
  --include-subdir  include the Tutorial-1.0-Darwin subdirectory
  --exclude-subdir  exclude the Tutorial-1.0-Darwin subdirectory
  --skip-license    accept license
EOF
  exit 1
}

cpack_echo_exit()
{
  echo $1
  exit 1
}

# Display version
cpack_version()
{
  echo "Tutorial Installer Version: 1.0, Copyright (c) Humanity"
}

# Helper function to fix windows paths.
cpack_fix_slashes ()
{
  echo "$1" | sed 's/\\/\//g'
}

interactive=TRUE
cpack_skip_license=FALSE
cpack_include_subdir=""
for a in "$@"; do
  if echo $a | grep "^--prefix=" > /dev/null 2> /dev/null; then
    cpack_prefix_dir=`echo $a | sed "s/^--prefix=//"`
    cpack_prefix_dir=`cpack_fix_slashes "${cpack_prefix_dir}"`
  fi
  if echo $a | grep "^--help" > /dev/null 2> /dev/null; then
    cpack_usage
  fi
  if echo $a | grep "^--version" > /dev/null 2> /dev/null; then
    cpack_version
    exit 2
  fi
  if echo $a | grep "^--include-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=TRUE
  fi
  if echo $a | grep "^--exclude-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=FALSE
  fi
  if echo $a | grep "^--skip-license" > /dev/null 2> /dev/null; then
    cpack_skip_license=TRUE
  fi
done

if [ "x${cpack_include_subdir}x" != "xx" -o "x${cpack_skip_license}x" = "xTRUEx" ]
then
  interactive=FALSE
fi

cpack_version
echo "This is a self-extracting archive."
toplevel="`pwd`"
if [ "x${cpack_prefix_dir}x" != "xx" ]
then
  toplevel="${cpack_prefix_dir}"
fi

echo "The archive will be extracted to: ${toplevel}"

if [ "x${interactive}x" = "xTRUEx" ]
then
  echo ""
  echo "If you want to stop extracting, please press <ctrl-C>."

  if [ "x${cpack_skip_license}x" != "xTRUEx" ]
  then
    more << '____cpack__here_doc____'
This is the open source License.txt file introduced in
CMake/Tutorial/Step7...

____cpack__here_doc____
    echo
    while true
      do
        echo "Do you accept the license? [yn]: "
        read line leftover
        case ${line} in
          y* | Y*)
            cpack_license_accepted=TRUE
            break;;
          n* | N* | q* | Q* | e* | E*)
            echo "License not accepted. Exiting ..."
            exit 1;;
        esac
      done
  fi

  if [ "x${cpack_include_subdir}x" = "xx" ]
  then
    echo "By default the Tutorial will be installed in:"
    echo "  \"${toplevel}/Tutorial-1.0-Darwin\""
    echo "Do you want to include the subdirectory Tutorial-1.0-Darwin?"
    echo "Saying no will install in: \"${toplevel}\" [Yn]: "
    read line leftover
    cpack_include_subdir=TRUE
    case ${line} in
      n* | N*)
        cpack_include_subdir=FALSE
    esac
  fi
fi

if [ "x${cpack_include_subdir}x" = "xTRUEx" ]
then
  toplevel="${toplevel}/Tutorial-1.0-Darwin"
  mkdir -p "${toplevel}"
fi
echo
echo "Using target directory: ${toplevel}"
echo "Extracting, please wait..."
echo ""

# take the archive portion of this file and pipe it to tar
# the NUMERIC parameter in this command should be one more
# than the number of lines in this header file
# there are tails which don't understand the "-n" argument, e.g. on SunOS
# OTOH there are tails which complain when not using the "-n" argument (e.g. GNU)
# so at first try to tail some file to see if tail fails if used with "-n"
# if so, don't use "-n"
use_new_tail_syntax="-n"
tail $use_new_tail_syntax +1 "$0" > /dev/null 2> /dev/null || use_new_tail_syntax=""

extractor="pax -r"
command -v pax > /dev/null 2> /dev/null || extractor="tar xf -"

tail $use_new_tail_syntax +152 "$0" | gunzip | (cd "${toplevel}" && ${extractor}) || cpack_echo_exit "Problem unpacking the Tutorial-1.0-Darwin"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;
� e��b �}|Օ�d'��
�|&P�bG�W��eaO2jd��,a"Kc[ K�4J�fN����n_K?v��Σ����vS�f�G�v�v�䕅*�n�)��;��;�h,;���v{��̽��{�=�ܯ33�qG0�Z��p:�k��%���YQEC�UUQ]Q���UU-9]���
A��Њ!q�Uz��y��`O�rP��s9������m	=�B��Y��UU㪴���S��J!3������~vf� �v�����E��{�:��a88T�ٽA�Gn�4]�x����i����௳00:��X���Z��)f�7�������g��'�IU�뉎���Zn��>c�0y�P�ڭ��Z,��W��M�mV���~U��kQ]�}Vy�Sy#&:K����`�k��6�A�U�h3��U5��`�3�C�&��DϦ��ǈ�w�[����J��YƉ%������i��(O2r��؟�[�J��2,z���h���|j���#R�zlFy�L�Y/��Y�
�t���z�W`�����w��i���1�r���qlYFCQȞŠ���ú��}BL�@�r��h��p� �
�V��K!�lj�bVv��VyN*r�_,�>G�W'�ա`��@_(��dz�����|�*������l�#���`|����	��<l�I���@	����c�[�같,W���nԦ����_F��rW9(� |N3�},��m���яf�Ϯ��|k�־������Xnd��s��[)��_WA�JX;�^͟�E)��D����iA�hW�o�?���֪���$ON��?i�3t��|-��.)C�]_ A�U%�lj���j�bAxߛQ��SO�H��>I��'>�DV��hשT�&*C 6�R�W�����T�&��> lH^J��ZB�6׺��(�rA�۱�]T��<��Z�WyD�O-&U�J?������z=�ì1��D6kȔH
?aF=O`˓�1���)ex��>B*��~1�og�U;h*�9�p�Ǜ|7�B�[h��7ùqhG�>����'�e��C@\_Q?��j�<��v���L����&_W)��Ob�w瑖(I��2�]QIn�iG�9��)o�ǩ�A����>"�`�<�O��I�ry\�X�?���N:�����v�-�����/"��X�i|c3��-9f'���y�L�2����>�Ͷ؉�~�OmVo��f��i�}��a�#KBS9��}��>���~�����2}	i�Z;��"䜰� �K.a�߄tǵ8ޛS+!1��:�m0��v:J<ɗ<IY1'����1������!�2T�����S������`h��E<=�����WȀ~3u��4;�����/���_&9*j�_~ٝܵj�T�?�(�q?��P���H��{G�K�� ��7����ԣXt�x�r��2|�}H�K���V�Y�?FF�BY���JMy�b�1��u�?a��X�_
��-�����k�2�*xL��w�������3SSV{�*������O�$_�$Ӑl|FIN(���!e��:���:6�BI��U��WJ�Qv����<C2L՟+���jަ�=��}Z۸����?pkc��3�Ǘ�ĩ�#�ѷ�{��'>��/=iV�)����I3�M&&����g�ɟx�'S��d�T�t�E���#'�`��!��P�U(�����c�H�_P���$J���^O黍��\�X�Ϡ�w���R��U���Vv�̛LAwԚ�#[h�@-�S7�Ϗ����ur#�$���伏��&�g�y?9����|���#�	r�9�9?O�G��{���p�_�ܭS7������7�������`�A�}c_���^��~�-C
c1�8�F06���a����c
��؟c�c8���1vc�]3��=sa��ԁ��CC�c~L��Xc%{c�@Z:%V	�шx���)>�ۮ�~��]�g ����������~1_�ʻ���k�X����(i}׽/�c�
��P���(�*6	���}6�l��}˖?a�mE��\��"�e _�A��ň Hwi�x0��r�=����I�N�th1��[�����&�"]�tB^0�Kz��y'C|��|qK��:�.)��{+��Q��t|�{l� ������n�2!�7@m�6�����K�6��+����������������������������������������������������������������@�<���o��K����,���b�5,,aaoe�z6��Xfa���/���,����q>5��3�_/l+��]XQ���4�ꕪ��G�,l�	#��j���<~�"�iN ԼC�����D���#X�Ԯ�^5��⑰/���N!V4rI]�/P�z�C���I�J��|�|\�r��;A�ڢ�=H�,'-pU�����Dد#�xU|{L�X��6|#mc�KU;|�4��]�?��	{�.Y�p�����TCZ�K�V�X,�w���YbjB�/��M�5����t���թR�	q)�pm0�J��.MF*���!�J�T��|=S+$��}1U���zzE�+��k~dvΝ��3��wӺk��^��z���%��V�(�n�B\Te�Bqګ��b"떬��#�e#rT�Fn!������#1"Un�A���B��0��m�K�J���@GPW}0��0r�0CԘF�!e��d���4_L�K����Z]���>]#�#"���^�ڡu�*h��Ɯ�29�k���0�z��ɽ�5�C��簨
��M�iҫ���vk>������a�LZ�0a��Xd2��M�c�k�at����-�QZ���	�/�c�}�1�4����[��א^"�(�j8�"�җ�YC�h��X/o�t�$(m3�=�I�,t��M�f�?e��Y�Y�b[6]i���_��c���ηgӗz M_c�o������ڳ��e�#z����
�X
�28.��b8p`//�c��q)�ñ��qW
�ϯƶ�!�q��	t|\���.IPs����>7�w�{�9�j��g���潇���u>�ּv�y�U���޶f��rod���fۼ�m[�S�|��״}+��ilc��el\ӼQ���l�iULjWT�*�W���C	h����k3�N���mj�S���5j���*�l~WT�BGC]3	�ԵLbG�S�6�O�5Tzk-�G5�6�!Y�P_+�_����i�i)�R*ASb�h,�-�����0F��P���t:�TWK$�������Nך��SrUUTWT��qUUKNW���F��H�,$�/����k���.�:;g�C����	^x�gg��:a��.��ב|�U8T�ٽA�Gn�4]ƹ|���PN���-������XĒ�M�z�L1�������e�<��<a�L�d���(�*�=įXhL^F?�{tk!�qr����l�m&y�����M�U�W�u�.�%��Ψ+0C{%v�Tm�Ͱ�V��E���Hy[���&z6�p�<F�4���j���V*��2N,��X���wEL�dFy%BF��T��
�^��SƀE���zmVՐO���tDBjT��(6�s�\d���>k;3�&��D��Y���^O�F��c�帥��L�54��y�0NV�.�p���B�c`l��|N�������,����E���V�L�;�@y�3]gB� �͑��g�@��V'�ա`�j�_X��L��[���/�u~��ٶ��|�H�#m\D��0Nmy�v�@ǝW(�3��ZV��d��X��P�F��q�rP.�A��f>�X�� ����*�]ϵ���}q]�)������=L�K�����Ձ֎:zu�^�J�//_�������������������������������������������v%��2�ֶ��L��V������6��_C�2t��yRr�^�����pu�CR�܏�)M}!��Ƽ'(�:�z�eU/Q��HĞ�BP�r,;`���lOK1�#������b������\����#J�o��Tп����󩋀��c�<vۇeR�Y�IE���0�J}zQj����u_�����M=���k7�}'��/�g�%�C%���̦��w�J�@�k�Hʇ�2�?�otɿVm�zT�H�^*��k���;GX�H
�0��1b������O��Cb"�$�M]����4��2�����'!�h�AǵBV>�M�(C�����"ޏ���~��T1��?��՝N�01i���>Pk2��B���4Ϩ���F��^Ls%�e��`���2��輣�A��9���I�g��+:v����	Ӿ�/�l�&���I-Ƀq~ �HGĐ<v����%���㲃e����!-f��((6@�XZ��{�t�2䁔�#��v��WI�!yx�`;�&�~F�*��kp�H��dh(��ީ�)�ʡ��ǡ%㩟��t?)P�g*܏�7��F��6�#I�ߎ_jI V|�v�ԊB���O�0Y�����}�v�փ�n�,t��	��tڑd㿥�m�@7.!#���3o0��|�1.2㇍���D�7��#f�4^�L@I���ǠyG�I���e�Rp�(�y�����!��H)�ļ��	�~�[�qǣ�k�8I!%��qpX�G[��ϐ2��	�G�i{��jK�#
�Es캔2O
f}��a���}���L�s�o,�����(�7�e3D┗���S4�����})�����f}y ���U�C�����^g#I��;�w1�|�,a{X�?����8[��w�*4z�x0��Ķ�f��1b����Z�
C�k[������;���"XE�Z�G��'�7�����P]Av�u=c�cj;�Jw��1T&u�"����y��Y��õ �:�;�g��vh c���L'�R�>�`���ܸ1	��L��7��eJ���:(ߜr�n���c��[��P'L�o��)ÆЁ_<ռ�n.��{�{�0���_06#S�����H��?g�c�RV���$ć䔙��wN�'�T��9�~,u#���i%����L�?�=RKM�˔��.Oƍ��L�����S��р9G !���X5��غ�����F=�c|L���~9�g��|�˒g�ϰ5+mOz��`�?���,r��EF��R��r�'����o�J�De����t���1��-Dx]-0=�J��e�����vZ��Y�ai�\���߰�>���v��Ք�1�j(�"�_OMͥ~^�k�$��L����t��e~��2���L��=�����]�#�jO��Io����wS豠/t��R���t�ö���XR~�P��c��
fo8k��>�.�a�r-��f��O��Ŏ���j�M��3��;���ľ���t�:���$\�Kͷ�76n�a�c�;Eg�)K����)S7#������"矒�[��69O��Ir�%9�"����9���ϐ�P�g9��"r. �Br^F��s���W/���:u���g�t�i��	�g��W0�����0�^��	��c�1v3z<Oal'���S��;�<�jA��G0�	�=���:;ݓcl=����1v��c�{c�1�*�n��i�U`��.%+����5��N�˅W@�W�%)����$}�t��.��k���&��Uۛ6���Y{>�/ء����ߴ�߷_iz%��}�V���W�wY�y7(��.�L�� |D
`-���b�`$,	�B{�ץ��)����bB[�&ŷ'|1M�E"�鄼`݌������UB�]c�0��W���C�����f"���.wQ� <al@�=M�p�ust+������J�*�B0`�(�q,O���ql�`�gq�RA��IZ!��)�үb����=~��ǧ�ߏ�`��{,|����p��B�d��,|��yL��,\��b�����0�c��X����X�d�'�ft���b�������X^\��za�+�T���V�RU]U�HB���1aĔZ������/W�0P�yjWo��b�H�
�}��0rI]�/P�z�C���L�\.�/��1_P��<�Kۮú���`P��Ff)_�E:��lEjBZ�K7���UT�j4��X��׵�׶'����ԪZ� Z0�����H\�i�O���Te�u�ڼ��J�s%UZ8��<!V`��{�]��eԨ���^q��o\���wBG�-Z<ѣAo���j\�=>��3���H8^��� (�b#U�&��B��D\S;}~MG�*	PxeV��`$��nZM��#���5�0W�T��r�
���BX���fר0L�:�j��[8�=~����mns�(kW���J�2�c�ܙ�;C�x7�{���k�ZX��ջ��J�t�[�a���%��t��΋5��{Ĭ�,�Gr�Fd�W��d��dIe��h�cY���_	T\�!��&�&YD5��ݱ�N�?�����|1�~,2F���ka��	�}�FX��t���S;��`X��ݘ3��Ѱf#}B�l +��k��
��M�z|��P)�z�U�W�'tM��|�z�6Tjm�aFTAț���U����c�@����Y9����yc�=oď� �ݼ���m������N�	���5�N�;��vD��I��I�$��9���,���f綢"I**jvJN�H*j��!�|��p�(Q���2���h�}��d� \#u���"����}���#��h1���f����3����\L�G�"�`�یe���>����ZJ��NF���m��z	ӏ���c�v2��Rz���l)��h���~�ѣ��&���*���ZF�u��cF�1�eFoc��"foF��c�^q1���zFc���IF��u�Lo3z��:�|F�1��VJ�dt�џc�(����0��y���ݦ"J?e|߉�)FW1Z���]��{��><2@� ��_:n��НvQ����w �<�h��4޼\V�h<V�1�>
�A��M#��]���A�uB6��.7��/2���_��K�V�eC�����o���WP�c~���i�7�����������L�����o3~�>������4G~c}+����Y�m~[6���%�7�s���~�?�?R37���vŇ(���?j�Z���y=�7�s�+��ݚ���X��3������_d�7������7��w���7�#ץ������k'�7�s�7��q��#��?����Y�϶~�i�el�ͱ~c�}����o��o���u��l�����1��$�o�#��,_��g�,������g�s�7��O3��9�o�'�����u�?n�?��1�����c��Ə�/�b�u��f?ÿz��o�c��?V}[��X���%�[7G���_��?���Pa���X��O���'-�g�������������o�#��}Ң����#��]�[��-s���_����,�#����)�7�s���>���s�7��7��ϑ߸>Ȼ��~��ߠ7A�M�>F�qF��m\O<�h�z��(��n��O��P�h��m��:����6��+EJ���(ݶ�3��"	�>{(���)a3��X蔅��e��[�_[�j{6�[�1����"/�����������k��������8?���BWXh%?����}�	��8ށ�p�?8�� �"yp�ñ��p��"K \
�28.��@���ߋ�XG�Bz!���D���FH����˹=a���W���<WQ��wGUr����e��+��\e�'*�,e��,��y>9��3��|Zr>�I���d^�F�=�]�$3=)���d��Kf{P2�	I�G#Ӟ��~�m<"��({�o^��V2���G����ӫ��y;����q�7�{ø��4����kY�N5�&��l]�[k�?���.�!�\gN1���Y�kYn��*s��0�}]q�H���rC�����B�<sѲ��i�,˞��Z�qF*��?�w�����������nY���É*<Ӛ�� 
-�`4V���#�*��}3�l��P�²9�sGz�1-�0��1ϼW�j֧��Z���D�ZUh��DH'�����V7��Mm�&�+�&s�Ļ�3��fd$\d2�Ĵ��j��bĿ��XEK�?X1�q��zλ�ޠS�v8I�Τ�9�]�7���s��,օ5	Cs�;������䜃���u��zD���g#�inSO��X��T���b��n^"ׂ�WC�p�BHC���(o!�t��r�ݑ�LͿ@3��3���u]��QMڛ= �X�A��.g:1�+kEX��`���-0�绑W��F~�}�:���-��3rd�]"l4Z8��*�^I;�x����2�h��O�!3�d���{[�'�P_��~-�UGHsNK���R;-�rʹ��
P���QX��/Y��y5x)q-������%�Z|�?�������V�'@QX�YY^�өe�H"��V��Z�U�Z0��������֑�Z]�%׃�_�f��V�(��������\7,�������������A�"�_� ~�/��E��\-��@~A�`T����D@[}!�p:�k��%���YQEC�UUQ]Q���UU-9]UΊjA���JH����*�����Xg�,rX;���	��o����'���Zأ��j���r�������������YS�$��E�?������`��]0�Jԏ{�*+J��$S���ySK��i��xw��M!�˖�zok�\/���ţ��$
i�Q�1HQ-�΅%ؓa	����#��z���?���c�E�#�þ-��E��݅���@$kn�b�%F	K�-�������-�߸V	w�v8��w�Ԥ�g%��k\�N>�?��һ5�O�=�R$Jg�/�����q�KpQ,C��z6��.�=���F��6�H�Y
x����v���!츠�b��_�������������+*y� ������������������?��N�]Z,T9)>�:���U�Ԭ���*�+�U��� p����K��'�{e���Rg.���C������H@�"������|]ZIi9\�yt������'�uM���X1��UQnI��J�ф��'탲" U�H����5Ў��;���n��Kȁ΁K΀��;�P���#�T *bS5&/@�ś�R��~�{��vR�-��6� &�q"��z�*�N":Ǩ����8J��i�����>R0W�ĩ�^��\�������+�T=���ۦ�Y����6^��ߵސ*��G3A���A,�u�����J�X���]�����BP*����ԐV��ݴA.-�$h���F������]Z!��P2�t�v�Z�Z���n�T�i���7�Œ���jG�`�ʭ�RN� �E������̵�-��Mn��j��jZ�9�-o9��U�3��T��m����Vүx'��X�Z�)ޓ�4'Ps��d�V�3V�H1�.Wt���6L`2a���Y������_7M�pV7��~=�Ӷ[�?p���?�KQ-s��.�ӳ����i�6W��N��'�
P�ݾ��4�7�j��y,(�<j36�f)�ƅ$��#ծ�d���Ŧ�[�c��6+i&5Is@1�nQ�X3�a�H����k�:�zYX��%�	�,�l��8������M��r�0�b-�o'�mЖ�*wa�(��n�h����OZ����U�̒����$Amojm���3C�0҂��s�����1���ߚ*�����5�����n���=�X�G�3�����V�>]�W0<:�b8tLNZ�;<ݸ��я��ͤ�[0B� �E]�|��a�W��/3�X",e�k#+A�c�	�<.������� P>- ??��"��z�-�z����"�W������M�zZ�0�uy9��񝭛��mriڔ
��-z�d6���k�/��S�K�-�4������|qm��Y�Eմ�_]]]��������]o����X:����p�����w>SRqL�p�r�:����X��Y��:����@8��,,�)����n�t*y��&8����"^����ZS�5#�gkJW��M�+is�l�ۤ,v���,�߲�Yni�[�Z��6��lhoGuSS��"{e7z�(�jbHj�l�L�Gnw"-ѻ��S�,\E�V�Ů5�pd� .��_�2��[75�匸�X�r�y���`\/a�6��W���*5P��B��p`g���7���<�i����[��to�#��ͽ�M���f�3���i#��p��]/�^�|l���5�M�[��s\��/��s��>��4s��6��ҳ�C닄�� ���ݑD�����¹��n��aN�?ysf���VT����5�N��+\�|�� ����p0���i{p�o��l߰ ;?��P�>���������g�����Y͸ߟm4���s���{�,���̾��r���~00��}t/̺�O~ԗ��]�NƟ򥓋%�����<����q|4������rK�������a�r'y��i���]m2��h$���4��*�$c�F����U0�﬛����!�����
RO"��!�U�%P���9�N�0�����%_(��}���
�����/�w�#a�-u$�Q]�6o�?/�Jl����Zo�l�(-�'�>�5���ߓ[�`��J^d6�/8Ĳ6KUl&�I��$>�a;v�2���6[�I��ܤChذ�MQ���'nӄ��Ƀ�D8ggZ3��Λ֩���,��$e��M�9����9K��Ӹ\�Kk�G�J::��}�Piz<�_��@_I ?�ة�g���P~o�?��u�tm2���>��^8c:(oZ�f���v���l-�&t������������ޡe=|)���G��5Ó�Y�f��9�8v�+��#���q�:�D�*�8�Au=�q�e	�^�
a-UCt�\��*��!�����b/}�~�������M-��˭fO���xɵ��sg���Ͱ������?��V��ƘI�f�_}���^v���`����j\�.WqΒ����Y�n��F2^`���Ӱ��nv�4��*nvGa��Qz���~�����u��2���ֻ���f5m|Y�4_>����]��m7�U弆L�J��AO%^oϸ`����B���������X�� �zcD�R��(V�=�_ @�<�.BQ�$M�ɺ��y���o��Gxo�n�S�W����L��Ŗ�Ğ�f��N�1���B�gɪOv�[v|"!�ND%]�A��h��/�\�������g��+fF6���Y�ξ��m�$�_O@�>�1�WI���cfIɺ�/���a�ZKf.�W}�
�\i�L��&�D�Œ�s�����roqZ���R���GA(�kTpoq!���&"��I��%�9�;�(��q�e���&��oZH=n��8� �?B||��. ���1x��#�&��կ��^� ���C�K���L@�3��~��KԈ|���t1�݇.�����83��F��V3�,/,����HM��g�~���ņ�m��)�EA.��Ӯf����thp�C�@�.韑�~������?�ëB��X��}��._����wJ�=҅�c��TT9�T	R�L7�N�?��?3�)_P3ϣ��+�����-��R����OJ��Y�:�Yc����������~vf� ���R	��@d��r��a8zm���m��r���X̒UU�z�L1���Z�(/C���	fR%��(�S�Ѱ�D��<�P��-ʒ�vk!�V�!�?���3�6��i��Ōn����N�mf��v���/Y��c�zM�m��,��{J3�缃���6`���	��O�J,��^��)=�~8�#r���G��TZ+0Chg�u��݌�$�@]v?��Xn�+��c���c���6�jȧ��z:"!5��f���D���yuiV����vf�&��Dg�/��
��7��ї���2h����2p�@�$��2�NK���B1����@P0N�v�c��o�M��u�� l�]���@_��<'�.2�n1;Ў���~V<�����W�z���l�_�o�_������?�%m\��.#q�g�m7	��'�\ڎ�Lw�>F���D<f<����i{,3ّ��k��[���S~�y羑���A�2털
�\�����o'��w��W/����������������������������������������������������_�J���-���w��nw��*�o�t:>�퓎��NG��c�DA8�("d������(�p<���Ar��擰�8>�$+C����j	��o���߁%yP��hJ_�'&��wS�y�P�<�D���J��~|�hjs�;��2�?�j��c�)%�Z�F,�<��f���2|Q��ʲ�g�W�:�*�Arg���]���#�����g�����NG��\��<lW�����`�N:����#'��ĥϓ��z���}����і�AZ� &%k��d��/�)P��Rj��R}P���&�e���e��۩j�tS6ʀ%�E{]e�v��M���1��˧�0z@<T�G�{�[���խO�>@k�h=�����q\['L��K��J�}`S�������1�����ve�.�^��%C!{��.;�[6xz*�1%�?�uz�o��l���a���m�6J��{�I�r����]�FH5����Co�	���H��{G�K�� ��7����ԣXt�x�r��2|�}H�K��秮��Z�R�"���8{�P{�O�)5���A���Y�{a��: d�x,�zI�V�Ix8�M�ٳV�=�صr��<�<��4$�Q�J�gHY)�N)���M�P��{�����w��?z�2ϐ}�s%�S�۔�G���ݧ�����@���<��~8�f�F�:�����g��"e��I2wDv��$̚��J
%X���3��O�ɓ�P����*�<.ꋔ��GN�)�E��b(�*E]�I�%�IGR����}'Q�%�zJ�m�=��
�}�kO'�z7��w�����g�d
�����B��e���9u.0���M����0�n ��y9�����g��r~��G�����9r�<9?F�_"篐�_܉�z���[��[�n��H�e�x�M�tݨ��W0�/���c{c�1V>�������[��b����c�M<�Ɗ1�0��b�c-�r(9�� ��1�?��^U��/"���c鷐��ī�A�wP��-�0*���g�~�.|��q���[��b�l�梤M�]��(��+ �C1�W����$O���ل����-[��M��^_�:����|Y\�^#0?��{�-I���1N��������/$����$�O�ᗬ��c:��LY: +�J��I,\%�w;_ܒ���������*d�gGz����=�N�BX����k�L�y�Ql� A4
G���2������������������������������������������������������������������;������}_�X�
^��Y�d�:6����[n�]_K�p`�r�1y�������;������x��D���Y����ź�R��c�����oʯ{��;���Eu�Uus������������������������������������������������������������������b��;[!�S�{�Z�JUuU�#	]6oFL��~�/�y�rE0 Ӝ@�y��6zz�A$��=�%M���U�Z,	�BA�O�������j\Ot��p@�	#T����g���c�
�j�)j�O�h *V@۵�6�&��B��D\S;}~M�[�Z�*m�+�*\���_\���t`�w`��fC�*!?�W#q=��z<��VH�w�b���8XK�+�`M?2Ksg��%�ݴ��ĵ��w�-��*
q�[H���Q;w	��@�:3+�C�b�K����C<��U��?�a��1M�EvR���������c�-�D��V�b=��O�c�U�O�к�a����ݘћ�аV#y@��֣��V8XEU�lP���ǧww&�~=
7Ʒ��6_GH[R`����������>��؅��]�.�	�����ّw�v���D���u�.�S��VJ�9�����������}_�0��2�����}A�҅�02@i��!������c�v#�GYy/"e#��ҢAZ迴�G-�r1�n�ЏX��{��55�k-t���$�@�[脥��E��-�^�l����R8��q�ဣmǇ������p|�+�R����K�
�kH�$��Ǻ1�sdM�jfZX��s\�g_��:�{]>��|��y��Ӷ��v��������i˲����>��<me��c�47#�NE���P�Z>?(�ٞ��~m3�PT�oSۜ�,��Q�7�V�=�Ω�
|b�8�5�`L]�$v$:� h��#���*����i[ʐL���$��������^�z�ZTWu�y�i)�i) �X-�@!�
v���eo�#�������YSU%a������
J\�5�N�UUQ]Q���UU-9]55.Ar.�"�����S%�Ex ؓ���Em��Opݭ�������]�+�R�����5k�5�T�tA
�vѾ�*�kX�m��Z�zwc��^j���&7��&/85�X��B��0��8'�ᷲ�^�}"��m�3�Om���SU����j�rooy�����ٙ��r��O��<8N��)�|��z���t�.��J{6��t ThR���S�6yK�ty�����h38��Ql�\NUC�C���ar��E�&�<K��5�����*�4c�etQ��I��4}��L7���:�O�-��S0]�ly~9�pW���o��S}� �ߪ+ȋ�Da��	�{��s~�"nct�j��p�$�HUպ�Θ�G˭_�ɛ0����-���v��U���\(-2�Vh���,��!+��e�N�g�o;�$�뇄��]I�����.w���U|�����o�t,��t:�'����t2��P[��d��0.m�����H؈��~5"���pu7(���O���Aer�)E|�;���&ߥCd�g�%yx?^�Mm�u'�S��'H�۱���|�I��I����1e�"J-;�~��Կu�;T����kw��v���N:���;i�:m�r��vlW�����`�N:����#'��ĥ��(�>��@KK�Ǟ^��ү�y�X�O/�)P��M�y�h5�W4�̛|;�)e���2B��)�8��}94�*�#�������փ'H�4de�㸶n�x�$_�$�U��㘒|���	�]_'*ڕ���wx����4��C��x�r��T�cJ���&�4�vF�F��q��r:Ǳ_~ٝܵj���oϸzc�4�7�7�����R�c?�>�M��1y�
�=������j������)V�k�Q�q.����	;��2Tf|��^��|���`�,�B�R��W��{ʱk	̪��!O�O�7��g��R:�RVʮSJ��c�/�d�^%�}��e����3$C_�\I��T�6e�Q�� �q�)ǣJ��6�<sy|y�p^���u�;�8���}E��듆n��!%	�f𻢒�B��v|#�7�o�$)U�\^�pJ�E���#'����wj1y��.Ƀ���$:�k�I�*C����wwO=���@�Ay��Ӊ����VR�ʮ�y�)�ZSwL�{�6g:��Iv�oUݗ���&������ī�A�A���¨x⟵�m��5��!��n��e_�����6�w���8&�����_��b� <a��g���[��	�8n+2��:����|Y\�^#��}���&��p�%��[E�N��$_X
��z��v�B	M�aKL��J�(I�NI@�MJkf���-������n��'��+پ��9-��{Y�U�?��m�ޢ�_F�EE�� O�@���_ѧ6V_��34�}qѧm�-j\�Ȣ��G���Ԉ|x��}Z���B����}�-���Z�������e��߱��yd.��<r/�l3/�#m.������^;���촼�N�7������d/+�S����=˲K���f�;6J��F�]�=o#��l4��F�{��6r?����*l��g���{J��ɽѲ�"�<����Q�r)�H� ��K$�^���od��Y�"��zۍ�&��,<M��sL��}m.�3��)��W�z<*P=>����@��KS���kh}8���2��	�[�>ӕ`�0�j-Kw�t���d�E,]`�P�1��@�$�O!m�̏GṁO0��������ȺVOϛ�$<=Ϟi�8����e���J{6���M�ڲ�VK����-�vK~���{,���+,tȢ�h�_a��,��X�/[述��k��Y�Ş��y�Z_����g��f7��w�?�[Ĺn���-�ܷ��Ȕ\�t�e>�����pK�<�ؘ���c�\�Y����Z�������rL������qv��}� � 