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
  --include-subdir  include the Tutorial-1.0-Linux subdirectory
  --exclude-subdir  exclude the Tutorial-1.0-Linux subdirectory
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
    echo "  \"${toplevel}/Tutorial-1.0-Linux\""
    echo "Do you want to include the subdirectory Tutorial-1.0-Linux?"
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
  toplevel="${toplevel}/Tutorial-1.0-Linux"
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

tail $use_new_tail_syntax +152 "$0" | gunzip | (cd "${toplevel}" && ${extractor}) || cpack_echo_exit "Problem unpacking the Tutorial-1.0-Linux"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;
� ��0c �]t[řI~%qb�	��@yY�,�N(!r9��HX�"K��E��t�8l��pbL �]�ښ����Ӳ��RS	��&�`Ͳ�ui9�,���:!�������N '��jr�_�7�����^��3i�Ė��\.Wy�rPw�r�H��p�zܥ��ROY���v{��!��m��H�)�Scʝ.��C��OB�CJ�'"������r��/-�x��/����]����e�������UV�E�m�*�9�4�{>�ͤ�h2�u��Q�9��L�zZ��C�ͲQ^�"=�4g��x'�)�g��
�L���b:�����a�S1������RO;�|o�>����UL�Y���n�S^�9쳂�)K���Z��L�"=��ֿ���L~�,]���2��S���!]:������g�6=��lY4�TV�,*�Fb���e�e��d�Y�مM�}�ꍍ���1ƻ����\�>��c���<葉�'���7,�t'7�����s��&���U(�>e�B���Y���ᶙ�
+��e(�f��Z��d�������$ߝ&�-&�=&�/2��3��~�/��_j"�$_�	^k���� �0ɷ�D��DO�I�KM�s��{.1�g>�A�^��y�W���xL�OYUQ�R�P��pK$��5��x,�h��i�q�u��Ѥ/�}��o��o�۷�z�4E�����l$5��I����i
$#A%�T�@[u���R|�e
IZR�(jk"�M�Ķ���H����1�v}�䤖+J����v�PE�'k1ʎX�t� m��z�B��ē
��V�"*������>^��peut(��D23���V�V�J�d�7f9a�MV�Y���+Z�K�����dZ,O��\� Q��J"k	��c�"��RNB� �U@i����0OY�jDbL ��;"*K�8t%�H��J4��8����`��Js E�%���K����-AP�97����R�8]�r��5Պ��AWo�^,���wg���J	��o���'�yc�>���Ib�9�_C��c�g'�K?V�D������y�v��I�){���z���!�/O���|�:��E���o��V��y_H��5���L�O��ɽ���_���"pi����|e��ٗUz�G3/�;��.�lR*��q����?�3�Cn�#.�_x��
�8?	�L��|D�g	���O�v��*~߸@��LO>ʼk��p���V������+�7	x���
�o���!���r	x������W���>/�^�*��|���	�? ��lȆ?��q������
�=�o,�icW�jM�w�X��O/��G��&)��ȷ∏��m:��Kx�j����k���?���?�񹄿W�������/ |@�'��?��?��n�/$�<��L��?���/"�����ˉkc-�?�?-���K���_�o��Ŀ$�?���J�����W��F��H�.��!���������~�����������ϪWq��y3H~��,�������$�8D�W��3��]SL�ބ�`�ŝX�FA�(�ܳ�UL��w���`��������)u(��)(H6�xzl_�G!K�Z���Z�*����~[-���ʃdC��]�B��/�� 9��V���m��4B�z-��;�w����=9�-$�|C���Y��9���^�/CAgcۺ̓|�ݿ��BD��}���,�J�5����9	�I�`���S�b�u��	ѐ`K�'��T�OReS@�wO��er�}�(}f���@`��$m�{
��D�u��|Q����D�����ۉ!�~�� (h��_<8t��"�\T_���춌�0p�$^��%T��	^"���
���4��`%-�.�
�0H ��4��Kf��T�x�C&����~|7?�$���|�|�#���{
t{��ݩ��',��ݶc$��nXƞ���TG�Nb.��%�=��-�"��9L;��a��m3�m�7��w���9%�ic���w?�M���\D�w V���^ya��oh6(�c����B`����H��� �v��&�uWH�Hϴn�`�GES}#��3��1���}������^ipA��
�{C�X��g���� m��Q�u ��o�wRD�d��X�5r�:���Z@ٷ��|����%f��|}Td�`��];zI~Ŀr'��ﶃH� ����V���S�>}׺�ݹ�^D�=���۱����vY�+��	�E�o.Z�HL�_���k�o��O�ĞO�\n�|[7A�+��s!�����yf��ʽ�������s߻�d�c%����w�7m81gZY��Q��E}T��Sz���z�r��-��H����Df�|-�[|�rj��#�_h���	���IMpX\I������T��=K׎�&��I�����L�V��FȠ��>�-�n�*�;2��μ�iobِِِ�,xu0��ׄ�H<�@NԘ���p G,��N��ְ#yK*�;��7C\$���iL�*H�x�ơ���h��991G$Q#��ck �
;Pe��=�Fb-�4��A��0W�WM�{��8<���Ֆ9���_��'y��|�p:=t/�L?L�{�n�(����?��P�c@x?��t�O5� z7�}@�����y� �>K�� �뛀��S�ڠ��:d�[���P�,�-���|��;>�����捦ث��ZW4i[A'Z}��=�/�z���>(����q�pq��u|��Noo��k��<kX$�O�Z��X���Es����l�u�ʖ�7�_��v�U��	|ނ|���4�h?����g���i<�����>����בގ�͎o@��ж���[��?�G!~�_���g�w����H8�?�f���W}f��t�r~E�Zso�A?��gC�V�~Q����t�U\eφlȆlȆlȆlȆ��?
�?��&ܿ��b?f��OK����|�K;�Y���r_�3������tp����)?=��c�ǜW���M�i����x�{q���O�Q����,d����H'+(���}a�/K�$=�y���V�������"���iZ>�N1� K�f<�s��;Y�1Ɵ��j�-ko/�����h;����e���>F�=�� ���G s^�3��Y�!p������=G�x�;������{�n}�s�[���݅Ot���*����}6��K�<�sq��eO���{�r.WWV^�X�ؔ��)���,q���+S�w/b��P���2>��堻XGq0|��<�V�풳����a���W�|砽�ph$����5�`z���n"�6O���?!��P�C�ﯙ=�J��7˷�M �0|���|>���%������{�I�g��-f���I����`�3P��r��|��j��xh!zf�����̓<�a��C�V �w�W����}��A�`�i;��9�-a�I�Ӵ�}�
�T~�$o�O���6����E��-f�!=E0~�Z/5/\h3�_g��y���5���),o��=y����6��6�/̥���0�����*�=�`��uܚc��4��L��a�Z�w��H�g�����ӿl���\���v)��}z|a.�W֯����\c�/1=��G��_�yc�g��Yi�o1��y��zL�`�?�G����;����<��U�o������&�W�q}rx)���w���1я�	��#E	4E5Ђ H���fgeT(j��'� �+-�xS ���x"�R(ok���p��ع>���v%S�Qs"�VB����D����U�QRg���8�op�l����m�dX	�cI5�
R��+%�*�-u�|5T�fA�V⫯b!%��0�D�r��Mk*6@�T�RM�۶����>���RUWQ�S|��(�������uHY�ecEMu��bSUU��Ai�X����:H����p(��,�m\�(-�>Q��T�B�u>�����V5(���Jmm�GY��P���"��E[�J0��V�[�4+zV�zh	EbJ*�s�p��+|���Wҗ>�#f�{n2��B� ��Ns�G���Y�K��Zg"��4>�����)^� =�����ʨZ��v�r��!u�hT��sUR���x3�[:����J>���^��I��9Z�0�b�16\J>{��Y��c��i员nI�LIf�@L�n������>�$�`S2ɭ�������o�WδV|�mf���<GwO�p~I;P�O5�1=݉,/?%S��+��x�v%x���$�Ӆ����4���%����:��3��M4����V�w�D;r��j�	�9�qhsu� 5�"�Pq$� � ��5�ĵ�����,(U4f+�
�1
�%�� d�ڣ*�f���g_�� r,���8yJ:í�M�5��p�M0��;��vU!�T+}ɠ:�w�<��T!-䄷<��@}�����+"_3�����㟧��+���<H|��^>�?_���D�����y]�,����,����|ݑӅ�뎲�D�yz�.��n�ϭ��|}0��g��:'�|]���oAt͐��넜�I�[%��5H��uHN{Q�~]�=��)O��E9��r���?�үa<_g�SH?� ��H�# ��?� ��CRz�]O�R���j<&�wM�S�g��}Rz�T=�\N���~��^+�4��Rz�N��dI^����~������������ߔү���Z��r�oK�.��E��<����|�j�n�{8fI��Y���v�
�����^9}�E�W�G���󏘎��'X��}��춬���?ˢO��˰��CJ���l#����@��~1x�,���/?gx�n1�R!���/`����\"�?���5��)�I(���&�`��TJ �φ3�X0�
���p_�����;{�۹���p��Xs���:�y@}������۝i��e���=��>{��9˖�� i�T"r����f���ɰ�ݴ���x�����KCa�� �_]}���JMźMu��A��	4����-5���75�B��&��V�bd�=9����������v-/����w{J���\�P<�lЕᅌ�X���x���H��������sp��G?��7�����e%��������.¼+�`�U�9��5�K�{Jy�M�Q��
��G�k��7
{����1��nB��������-�b9�Y^�׎�З�Ck�ܡ�8v������!B{fR�u�ߡ�bN�<�;���
&Kw(p,#/��
���;t�qV4�G'2�
Fa�<Xy8W'_���u��&lvC��	V���w��NHr�T��׳x��F�̣����l&w����I�k�Q�a�;DV�' �Xmf� ù#~<L�,���7������݉F�:���&��L�L��,Ƹ�_a���v���L�S&��A�\y�>��W�~��p��þ�%��M�����ջ@��0,ކ�ڙQܤ��o`|��70�A��H�Q���4��r����ň�q�C�/����Y�>�Ix��y=�f�]�E��Ίl�R�x���ߔ_a���D����i����!_��?-�O���������=��A�g��v�����E�F���ś$�������P/�����Xы�{�PGx8�6C��XsO��@�μT�N���w���q��Z�#��U�dd�Y� I;�<�n��;$~)��L�O:gf��.���.�3\��;˚��X^ޙ]���o?������/���u�xg���\���zd�[Yn��i D�ou�a��g�\���3K/�L��"���g��g<��Iht���,�7���6�`��lg�{���4��lg���~�%�ٝ�lȆl����� p  