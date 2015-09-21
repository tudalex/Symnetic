main_input :: FromDevice(eth1, SNIFFER true, OUTBOUND false);

main_tee :: Tee(1);

in_LABS_CS :: Null;

pn_LABS_CS :: Paint(5);

isTCP1 :: IPClassifier(tcp, udp,-);

main_input[0] -> main_tee[0] -> [0]in_LABS_CS -> pn_LABS_CS;
                                                 pn_LABS_CS -> isTCP1;

nat_cl_LABS_CS :: IPClassifier(src net 172.16.4.0/10,-);

isTCP1[0] -> nat_cl_LABS_CS;
isTCP1[1] -> nat_cl_LABS_CS;

global_nat :: IPRewriter(keep 0 1, pattern 141.85.225.204 60000-65535 - - 2 3, keep 2 4);

nat_cl_LABS_CS[0] -> [1]global_nat;
nat_cl_LABS_CS[1] -> [2]global_nat;

main_tee[1] -> ToDevice()
