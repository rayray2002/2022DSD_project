/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : R-2020.09-SP5
// Date      : Wed Mar 30 20:09:34 2022
/////////////////////////////////////////////////////////////


module permute ( W, clk, rst, finish, valid, J );
  input [2:0] W;
  output [2:0] J;
  input clk, rst, finish;
  output valid;
  wire   N81, N82, N83, N84, N86, N87, N88, N89, N90, N91, N92,
         \permutaion[0][2] , \permutaion[0][1] , \permutaion[0][0] ,
         \permutaion[1][2] , \permutaion[1][1] , \permutaion[1][0] ,
         \permutaion[2][2] , \permutaion[2][1] , \permutaion[2][0] ,
         \permutaion[3][2] , \permutaion[3][1] , \permutaion[3][0] ,
         \permutaion[4][2] , \permutaion[4][1] , \permutaion[4][0] ,
         \permutaion[5][2] , \permutaion[5][1] , \permutaion[5][0] ,
         \permutaion[6][2] , \permutaion[6][1] , \permutaion[6][0] ,
         \permutaion[7][2] , \permutaion[7][1] , \permutaion[7][0] , N93, N94,
         N95, N96, N97, N98, N112, N113, N114, \swapTarget[2] , N133, N134,
         N135, N252, N253, N254, N255, N256, N257, N258, N259, N260, N330, n54,
         n56, n57, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89,
         n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102,
         n103, n104, n105, n106, n107, n108, n109, n110, n111, n112, n113,
         n114, n115, n116, n117, n118, n119, n120, n121, n122, n123, n124,
         n125, n126, n127, n128, n129, n130, n131, n132, n133, n134, n135,
         n136, n137, n138, n139, n140, n141, n142, n143, n144, n145, n146,
         n147, n148, n149, n150, n151, n152, n153, n154, n155, n156, n157,
         n158, n159, n160, n161, n162, n163, n164, n165, n166, n167, n168,
         n169, n170, n171, n172, n173, n174, n175, n176, n177, n178, n179,
         n180, n181, n182, n183, n184, n185, n186, n187, n188, n189, n190,
         n191, n192, n193, n194, n195, n196, n197, n198, n199, n200, n201,
         n202, n203, n204, n205, n206, n207, n208, n210, n211, n212, n213,
         n214, n215, n216, n217, n218, n219, n220, n221, n222, n223, n224,
         n225, n226, n227, n228, n229, n230, n231, n232, n233, n234, n235,
         n236, n237, n238, n239, n240, n241, n242, n243, n244, n245, n246,
         n247, n248, n249, n250, n251, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10,
         n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24,
         n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38,
         n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52,
         n53, n55, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69,
         n70, n71, n72, n73, n74, n75, n76, n77, n209, n252, n253, n254, n255,
         n256, n257, n258, n259, n260, n261, n262, n263, n264, n265, n266,
         n267, n268, n269, n270, n271, n272, n273, n274, n275, n276, n277,
         n278, n279, n280, n281, n282, n283, n284, n285, n286, n287, n288,
         n289, n290, n291, n292, n293, n294, n295, n296, n297, n298, n299,
         n300, n301, n302, n303, n304, n305, n306, n307, n308, n309, n310,
         n311, n312, n313, n314, n315, n316, n317, n318, n319, n320, n321,
         n322, n323, n324, n325, n326, n327, n328, n329, n330, n331, n332,
         n333, n334, n335, n336;
  wire   [1:0] state;
  assign N81 = W[0];
  assign N82 = W[1];
  assign N83 = W[2];
  assign valid = N330;

  DFFX1 \swapTarget_reg[3]  ( .D(n242), .CK(clk), .QN(n54) );
  DFFQX1 \state_reg[1]  ( .D(n248), .CK(clk), .Q(state[1]) );
  DFFQX1 \swapTarget_reg[2]  ( .D(n243), .CK(clk), .Q(\swapTarget[2] ) );
  DFFX1 \swapTarget_reg[0]  ( .D(n245), .CK(clk), .QN(n57) );
  DFFX1 \swapTarget_reg[1]  ( .D(n244), .CK(clk), .QN(n56) );
  DFFQX1 \pivotIndex_reg[2]  ( .D(n250), .CK(clk), .Q(N86) );
  DFFQX1 \permutaion_reg[6][2]  ( .D(n230), .CK(clk), .Q(\permutaion[6][2] )
         );
  DFFQX1 \permutaion_reg[7][2]  ( .D(n233), .CK(clk), .Q(\permutaion[7][2] )
         );
  DFFQX1 \permutaion_reg[6][1]  ( .D(n231), .CK(clk), .Q(\permutaion[6][1] )
         );
  DFFQX1 \permutaion_reg[6][0]  ( .D(n232), .CK(clk), .Q(\permutaion[6][0] )
         );
  DFFQX1 \pivotIndex_reg[0]  ( .D(n251), .CK(clk), .Q(N84) );
  DFFQX1 \permutaion_reg[7][1]  ( .D(n234), .CK(clk), .Q(\permutaion[7][1] )
         );
  DFFQX1 \permutaion_reg[7][0]  ( .D(n235), .CK(clk), .Q(\permutaion[7][0] )
         );
  DFFQX1 \permutaion_reg[5][2]  ( .D(n227), .CK(clk), .Q(\permutaion[5][2] )
         );
  DFFQX1 \permutaion_reg[5][0]  ( .D(n229), .CK(clk), .Q(\permutaion[5][0] )
         );
  DFFQX1 \permutaion_reg[5][1]  ( .D(n228), .CK(clk), .Q(\permutaion[5][1] )
         );
  DFFQX1 \swapIndex_reg[2]  ( .D(n239), .CK(clk), .Q(N92) );
  DFFQX1 \state_reg[0]  ( .D(n247), .CK(clk), .Q(state[0]) );
  DFFX4 \pivotIndex_reg[1]  ( .D(n246), .CK(clk), .Q(n1), .QN(n2) );
  DFFX1 \index_reg[2]  ( .D(n249), .CK(clk), .Q(N89), .QN(n320) );
  DFFX1 \index_reg[0]  ( .D(n241), .CK(clk), .Q(N87), .QN(n272) );
  DFFX1 \permutaion_reg[1][0]  ( .D(n217), .CK(clk), .Q(\permutaion[1][0] ), 
        .QN(n28) );
  DFFX1 \permutaion_reg[1][2]  ( .D(n215), .CK(clk), .Q(\permutaion[1][2] ), 
        .QN(n30) );
  DFFX1 \permutaion_reg[1][1]  ( .D(n216), .CK(clk), .Q(\permutaion[1][1] ), 
        .QN(n29) );
  DFFX1 \permutaion_reg[2][1]  ( .D(n219), .CK(clk), .Q(\permutaion[2][1] ), 
        .QN(n32) );
  DFFX1 \permutaion_reg[2][2]  ( .D(n218), .CK(clk), .Q(\permutaion[2][2] ), 
        .QN(n33) );
  DFFX1 \permutaion_reg[2][0]  ( .D(n220), .CK(clk), .Q(\permutaion[2][0] ), 
        .QN(n31) );
  DFFX2 \swapIndex_reg[0]  ( .D(n237), .CK(clk), .Q(N90), .QN(n289) );
  DFFX2 \swapIndex_reg[1]  ( .D(n238), .CK(clk), .Q(N91), .QN(n290) );
  DFFX1 \index_reg[1]  ( .D(n240), .CK(clk), .Q(N88), .QN(n271) );
  DFFX2 \permutaion_reg[3][2]  ( .D(n221), .CK(clk), .Q(\permutaion[3][2] ) );
  DFFX2 \permutaion_reg[3][1]  ( .D(n222), .CK(clk), .Q(\permutaion[3][1] ) );
  DFFX2 \permutaion_reg[3][0]  ( .D(n223), .CK(clk), .Q(\permutaion[3][0] ) );
  DFFX2 \permutaion_reg[0][0]  ( .D(n214), .CK(clk), .Q(\permutaion[0][0] ), 
        .QN(n334) );
  DFFX2 \permutaion_reg[0][1]  ( .D(n213), .CK(clk), .Q(\permutaion[0][1] ), 
        .QN(n333) );
  DFFX2 \permutaion_reg[0][2]  ( .D(n236), .CK(clk), .Q(\permutaion[0][2] ), 
        .QN(n335) );
  DFFX2 \permutaion_reg[4][1]  ( .D(n225), .CK(clk), .Q(\permutaion[4][1] ) );
  DFFX2 \permutaion_reg[4][0]  ( .D(n226), .CK(clk), .Q(\permutaion[4][0] ) );
  DFFX2 \permutaion_reg[4][2]  ( .D(n224), .CK(clk), .Q(\permutaion[4][2] ) );
  OAI222XL U3 ( .A0(\permutaion[4][2] ), .A1(n36), .B0(\permutaion[3][2] ), 
        .B1(n35), .C0(\permutaion[0][2] ), .C1(n41), .Y(n17) );
  OAI222XL U4 ( .A0(\permutaion[4][1] ), .A1(n36), .B0(\permutaion[3][1] ), 
        .B1(n35), .C0(\permutaion[0][1] ), .C1(n41), .Y(n16) );
  OAI211X1 U5 ( .A0(n40), .A1(n102), .B0(n98), .C0(n111), .Y(n103) );
  NAND3X1 U6 ( .A(n2), .B(n34), .C(n42), .Y(n89) );
  OAI211X1 U7 ( .A0(n40), .A1(n89), .B0(n98), .C0(n99), .Y(n87) );
  CLKBUFX3 U8 ( .A(N86), .Y(n41) );
  OAI222XL U9 ( .A0(\permutaion[4][0] ), .A1(n36), .B0(\permutaion[3][0] ), 
        .B1(n35), .C0(\permutaion[0][0] ), .C1(n41), .Y(n15) );
  NOR2X2 U10 ( .A(n271), .B(n272), .Y(n267) );
  NOR2X2 U11 ( .A(n271), .B(N87), .Y(n268) );
  NOR2X2 U12 ( .A(n290), .B(N90), .Y(n286) );
  OAI32XL U13 ( .A0(N90), .A1(N91), .A2(n298), .B0(n81), .B1(n40), .Y(n177) );
  INVX3 U14 ( .A(n41), .Y(n34) );
  NOR2X2 U15 ( .A(n313), .B(n41), .Y(n24) );
  OAI22X1 U16 ( .A0(n270), .A1(n320), .B0(N89), .B1(n269), .Y(N96) );
  OAI22X1 U17 ( .A0(n253), .A1(n34), .B0(n41), .B1(n252), .Y(N93) );
  NOR2X2 U18 ( .A(n34), .B(n313), .Y(n11) );
  OAI22X1 U19 ( .A0(n320), .A1(n262), .B0(N89), .B1(n261), .Y(N97) );
  NOR2X2 U20 ( .A(n34), .B(n42), .Y(n12) );
  OAI22X1 U21 ( .A0(n34), .A1(n68), .B0(n41), .B1(n67), .Y(N95) );
  CLKINVX1 U22 ( .A(n78), .Y(n297) );
  CLKBUFX3 U23 ( .A(n97), .Y(n40) );
  OAI211XL U24 ( .A0(n40), .A1(n113), .B0(n98), .C0(n145), .Y(n142) );
  INVXL U25 ( .A(N97), .Y(n318) );
  INVXL U26 ( .A(n180), .Y(n296) );
  NAND4BXL U27 ( .AN(n190), .B(n292), .C(n191), .D(n40), .Y(n188) );
  NAND2XL U28 ( .A(n41), .B(n2), .Y(n19) );
  AOI32XL U29 ( .A0(n100), .A1(n289), .A2(N91), .B0(n325), .B1(n112), .Y(n111)
         );
  AOI32XL U30 ( .A0(n100), .A1(n290), .A2(N90), .B0(n325), .B1(n101), .Y(n99)
         );
  OAI211XL U31 ( .A0(n40), .A1(n114), .B0(n98), .C0(n131), .Y(n128) );
  AOI31XL U32 ( .A0(N90), .A1(n100), .A2(N91), .B0(n325), .Y(n131) );
  OAI211XL U33 ( .A0(n40), .A1(n136), .B0(n173), .C0(n98), .Y(n172) );
  OAI211XL U34 ( .A0(n40), .A1(n125), .B0(n166), .C0(n98), .Y(n164) );
  OAI32XL U35 ( .A0(n37), .A1(n1), .A2(n313), .B0(n187), .B1(n2), .Y(n246) );
  AOI22XL U36 ( .A0(n25), .A1(n29), .B0(n24), .B1(n32), .Y(n5) );
  AOI22XL U37 ( .A0(n25), .A1(n28), .B0(n24), .B1(n31), .Y(n4) );
  AOI22XL U38 ( .A0(n25), .A1(n30), .B0(n24), .B1(n33), .Y(n6) );
  OAI22X1 U39 ( .A0(n34), .A1(n72), .B0(n41), .B1(n71), .Y(N94) );
  CLKINVX1 U40 ( .A(n38), .Y(n321) );
  NAND2X1 U41 ( .A(N133), .B(n38), .Y(n91) );
  NAND3X1 U42 ( .A(n42), .B(n2), .C(n41), .Y(n124) );
  NOR3X1 U43 ( .A(n325), .B(rst), .C(n177), .Y(n78) );
  CLKBUFX3 U44 ( .A(N84), .Y(n42) );
  CLKBUFX3 U45 ( .A(n95), .Y(n38) );
  NAND2X1 U46 ( .A(n315), .B(n325), .Y(n151) );
  CLKINVX1 U47 ( .A(n80), .Y(n306) );
  INVX1 U48 ( .A(n11), .Y(n36) );
  CLKINVX1 U49 ( .A(n127), .Y(n312) );
  INVX3 U50 ( .A(n39), .Y(n325) );
  OAI31X1 U51 ( .A0(n141), .A1(n316), .A2(n39), .B0(n142), .Y(n133) );
  CLKINVX1 U52 ( .A(n142), .Y(n304) );
  CLKINVX1 U53 ( .A(n83), .Y(n324) );
  NOR2X1 U54 ( .A(n321), .B(n307), .Y(n80) );
  CLKINVX1 U55 ( .A(n110), .Y(n305) );
  NOR2X1 U56 ( .A(n125), .B(n39), .Y(n149) );
  CLKINVX1 U57 ( .A(n91), .Y(n322) );
  CLKINVX1 U58 ( .A(n120), .Y(n309) );
  CLKINVX1 U59 ( .A(n86), .Y(n323) );
  CLKINVX1 U60 ( .A(n37), .Y(n327) );
  CLKINVX1 U61 ( .A(n186), .Y(n295) );
  INVX1 U62 ( .A(n12), .Y(n35) );
  NAND2X1 U63 ( .A(n113), .B(n124), .Y(n127) );
  INVX3 U64 ( .A(n125), .Y(n310) );
  CLKINVX1 U65 ( .A(n113), .Y(n311) );
  INVX3 U66 ( .A(n124), .Y(n316) );
  INVX3 U67 ( .A(n136), .Y(n315) );
  NAND3X1 U68 ( .A(n2), .B(n34), .C(n313), .Y(n81) );
  NAND2X1 U69 ( .A(n125), .B(n136), .Y(n141) );
  CLKINVX1 U70 ( .A(n114), .Y(n314) );
  CLKINVX1 U71 ( .A(n87), .Y(n301) );
  CLKINVX1 U72 ( .A(n103), .Y(n300) );
  OAI22XL U73 ( .A0(n87), .A1(n28), .B0(n301), .B1(n94), .Y(n217) );
  AOI22X1 U74 ( .A0(n38), .A1(n96), .B0(N255), .B1(n325), .Y(n94) );
  OAI2BB2XL U75 ( .B0(n330), .B1(n89), .A0N(n89), .A1N(N95), .Y(n96) );
  OAI22XL U76 ( .A0(n87), .A1(n29), .B0(n301), .B1(n92), .Y(n216) );
  AOI221XL U77 ( .A0(n80), .A1(n89), .B0(N256), .B1(n325), .C0(n93), .Y(n92)
         );
  OAI21XL U78 ( .A0(n83), .A1(n89), .B0(n336), .Y(n93) );
  OAI22XL U79 ( .A0(n87), .A1(n30), .B0(n301), .B1(n88), .Y(n215) );
  AOI221XL U80 ( .A0(n309), .A1(n89), .B0(N257), .B1(n325), .C0(n90), .Y(n88)
         );
  OAI21XL U81 ( .A0(n89), .A1(n91), .B0(n336), .Y(n90) );
  OAI22XL U82 ( .A0(n103), .A1(n31), .B0(n300), .B1(n108), .Y(n220) );
  AOI221XL U83 ( .A0(n305), .A1(n102), .B0(N252), .B1(n325), .C0(n109), .Y(
        n108) );
  OAI21XL U84 ( .A0(n86), .A1(n102), .B0(n336), .Y(n109) );
  OAI22XL U85 ( .A0(n103), .A1(n32), .B0(n300), .B1(n106), .Y(n219) );
  AOI22X1 U86 ( .A0(n38), .A1(n107), .B0(N253), .B1(n325), .Y(n106) );
  OAI2BB2XL U87 ( .B0(n331), .B1(n102), .A0N(n102), .A1N(N94), .Y(n107) );
  OAI22XL U88 ( .A0(n103), .A1(n33), .B0(n300), .B1(n104), .Y(n218) );
  AOI221XL U89 ( .A0(n309), .A1(n102), .B0(N254), .B1(n325), .C0(n105), .Y(
        n104) );
  OAI21XL U90 ( .A0(n91), .A1(n102), .B0(n336), .Y(n105) );
  CLKBUFX3 U91 ( .A(n119), .Y(n39) );
  NAND2X1 U92 ( .A(n198), .B(n336), .Y(n119) );
  NAND3X1 U93 ( .A(n192), .B(n180), .C(n38), .Y(n97) );
  OAI31X1 U94 ( .A0(n127), .A1(n310), .A2(n39), .B0(n128), .Y(n116) );
  AOI31X1 U95 ( .A0(n289), .A1(n290), .A2(n146), .B0(n325), .Y(n145) );
  OAI21X1 U96 ( .A0(n39), .A1(n141), .B0(n152), .Y(n148) );
  NOR2BX1 U97 ( .AN(n172), .B(n321), .Y(n168) );
  OAI22XL U98 ( .A0(n297), .A1(n335), .B0(n78), .B1(n175), .Y(n236) );
  AOI221XL U99 ( .A0(n309), .A1(n81), .B0(N260), .B1(n325), .C0(n176), .Y(n175) );
  OAI21XL U100 ( .A0(n81), .A1(n91), .B0(n336), .Y(n176) );
  OAI22XL U101 ( .A0(n297), .A1(n334), .B0(n78), .B1(n84), .Y(n214) );
  AOI221XL U102 ( .A0(n305), .A1(n81), .B0(N258), .B1(n325), .C0(n85), .Y(n84)
         );
  OAI21XL U103 ( .A0(n81), .A1(n86), .B0(n336), .Y(n85) );
  OAI22XL U104 ( .A0(n297), .A1(n333), .B0(n78), .B1(n79), .Y(n213) );
  AOI221XL U105 ( .A0(n80), .A1(n81), .B0(N259), .B1(n325), .C0(n82), .Y(n79)
         );
  OAI21XL U106 ( .A0(n81), .A1(n83), .B0(n336), .Y(n82) );
  OAI22XL U107 ( .A0(N96), .A1(n308), .B0(n206), .B1(n207), .Y(n205) );
  NOR2XL U108 ( .A(N94), .B(n318), .Y(n207) );
  AOI211XL U109 ( .A0(N94), .A1(n318), .B0(n317), .C0(N95), .Y(n206) );
  OAI21X1 U110 ( .A0(n315), .A1(n39), .B0(n164), .Y(n159) );
  NOR2X1 U111 ( .A(n291), .B(n40), .Y(n146) );
  CLKINVX1 U112 ( .A(n42), .Y(n254) );
  NAND2X1 U113 ( .A(n39), .B(n172), .Y(n167) );
  CLKINVX1 U114 ( .A(n152), .Y(n303) );
  CLKINVX1 U115 ( .A(n164), .Y(n302) );
  OAI31X1 U116 ( .A0(n321), .A1(n296), .A2(n192), .B0(n37), .Y(n185) );
  CLKINVX1 U117 ( .A(n128), .Y(n299) );
  NAND2X1 U118 ( .A(n38), .B(n185), .Y(n182) );
  INVX1 U119 ( .A(N93), .Y(n308) );
  OAI21X1 U120 ( .A0(n321), .A1(n180), .B0(n292), .Y(n178) );
  NAND2X1 U121 ( .A(n38), .B(n178), .Y(n179) );
  OAI22XL U122 ( .A0(n289), .A1(n178), .B0(n179), .B1(n272), .Y(n237) );
  NAND3BX1 U123 ( .AN(n211), .B(n336), .C(n208), .Y(n197) );
  NAND2X1 U124 ( .A(N134), .B(n38), .Y(n83) );
  NAND2X1 U125 ( .A(n292), .B(n37), .Y(n210) );
  OA21XL U126 ( .A0(n42), .A1(n37), .B0(n210), .Y(n187) );
  CLKBUFX3 U127 ( .A(n184), .Y(n37) );
  NAND2X1 U128 ( .A(n211), .B(n336), .Y(n184) );
  NAND2X1 U129 ( .A(N95), .B(n38), .Y(n110) );
  NAND2XL U130 ( .A(n38), .B(N93), .Y(n120) );
  NAND2X1 U131 ( .A(N135), .B(n38), .Y(n86) );
  NAND2X1 U132 ( .A(n327), .B(n193), .Y(n191) );
  OAI21XL U133 ( .A0(N114), .A1(n308), .B0(n194), .Y(n193) );
  OAI2BB2XL U134 ( .B0(n195), .B1(n196), .A0N(n308), .A1N(N114), .Y(n194) );
  OAI21XL U135 ( .A0(n328), .A1(n188), .B0(n189), .Y(n247) );
  OAI21XL U136 ( .A0(n327), .A1(n190), .B0(n188), .Y(n189) );
  INVXL U137 ( .A(N96), .Y(n319) );
  OA21XL U138 ( .A0(n38), .A1(n190), .B0(n188), .Y(n248) );
  OAI221XL U139 ( .A0(n319), .A1(n186), .B0(n295), .B1(n329), .C0(n37), .Y(
        n243) );
  NAND2X1 U140 ( .A(n296), .B(n38), .Y(n186) );
  INVX1 U141 ( .A(N94), .Y(n307) );
  NOR2X1 U142 ( .A(N113), .B(n307), .Y(n196) );
  CLKINVX1 U143 ( .A(N98), .Y(n317) );
  INVXL U144 ( .A(N95), .Y(n294) );
  INVX1 U145 ( .A(N134), .Y(n331) );
  INVX1 U146 ( .A(N135), .Y(n330) );
  INVXL U147 ( .A(N133), .Y(n332) );
  INVX3 U148 ( .A(n42), .Y(n313) );
  NAND3X2 U149 ( .A(n313), .B(n2), .C(n41), .Y(n113) );
  NAND3X2 U150 ( .A(n1), .B(n34), .C(n42), .Y(n114) );
  NAND3X2 U151 ( .A(n313), .B(n34), .C(n1), .Y(n102) );
  NAND3X2 U152 ( .A(n1), .B(n313), .C(n41), .Y(n125) );
  NAND3X2 U153 ( .A(n42), .B(n1), .C(n41), .Y(n136) );
  NOR2X1 U154 ( .A(n326), .B(n328), .Y(N330) );
  NOR2X1 U155 ( .A(n64), .B(N82), .Y(n53) );
  OAI22XL U156 ( .A0(n61), .A1(n62), .B0(N83), .B1(n60), .Y(J[2]) );
  INVXL U157 ( .A(N83), .Y(n62) );
  NAND2X1 U158 ( .A(n312), .B(n102), .Y(n101) );
  NAND2X1 U159 ( .A(n113), .B(n114), .Y(n112) );
  NOR2BX2 U160 ( .AN(n174), .B(rst), .Y(n98) );
  NAND4X1 U161 ( .A(n312), .B(n325), .C(n114), .D(n102), .Y(n174) );
  INVX3 U162 ( .A(rst), .Y(n336) );
  NOR2X1 U163 ( .A(n40), .B(N92), .Y(n100) );
  NOR2X1 U164 ( .A(n208), .B(rst), .Y(n95) );
  OAI2BB2XL U165 ( .B0(n299), .B1(n115), .A0N(\permutaion[3][2] ), .A1N(n116), 
        .Y(n221) );
  AOI211X1 U166 ( .A0(n314), .A1(n322), .B0(n117), .C0(rst), .Y(n115) );
  OAI22XL U167 ( .A0(n118), .A1(n39), .B0(n314), .B1(n120), .Y(n117) );
  AOI222XL U168 ( .A0(\permutaion[0][2] ), .A1(n311), .B0(n310), .B1(
        \permutaion[2][2] ), .C0(n316), .C1(\permutaion[1][2] ), .Y(n118) );
  OAI2BB2XL U169 ( .B0(n299), .B1(n126), .A0N(\permutaion[3][0] ), .A1N(n116), 
        .Y(n223) );
  AOI22X1 U170 ( .A0(n38), .A1(n129), .B0(n325), .B1(n130), .Y(n126) );
  OAI222XL U171 ( .A0(n28), .A1(n124), .B0(n31), .B1(n125), .C0(n334), .C1(
        n113), .Y(n130) );
  OAI22XL U172 ( .A0(n314), .A1(n294), .B0(n330), .B1(n114), .Y(n129) );
  OAI2BB2XL U173 ( .B0(n299), .B1(n121), .A0N(\permutaion[3][1] ), .A1N(n116), 
        .Y(n222) );
  AOI22X1 U174 ( .A0(n38), .A1(n122), .B0(n325), .B1(n123), .Y(n121) );
  OAI222XL U175 ( .A0(n29), .A1(n124), .B0(n32), .B1(n125), .C0(n333), .C1(
        n113), .Y(n123) );
  OAI22XL U176 ( .A0(n314), .A1(n307), .B0(n331), .B1(n114), .Y(n122) );
  OAI2BB2XL U177 ( .B0(n304), .B1(n132), .A0N(\permutaion[4][2] ), .A1N(n133), 
        .Y(n224) );
  AOI22X1 U178 ( .A0(n38), .A1(n134), .B0(n325), .B1(n135), .Y(n132) );
  OAI222XL U179 ( .A0(n30), .A1(n125), .B0(n33), .B1(n136), .C0(n124), .C1(
        n335), .Y(n135) );
  OAI22XL U180 ( .A0(n311), .A1(n308), .B0(n332), .B1(n113), .Y(n134) );
  OAI2BB2XL U181 ( .B0(n304), .B1(n140), .A0N(\permutaion[4][0] ), .A1N(n133), 
        .Y(n226) );
  AOI211X1 U182 ( .A0(n311), .A1(n323), .B0(n143), .C0(rst), .Y(n140) );
  OAI22XL U183 ( .A0(n144), .A1(n39), .B0(n311), .B1(n110), .Y(n143) );
  AOI222XL U184 ( .A0(n316), .A1(\permutaion[0][0] ), .B0(n315), .B1(
        \permutaion[2][0] ), .C0(n310), .C1(\permutaion[1][0] ), .Y(n144) );
  OAI2BB2XL U185 ( .B0(n304), .B1(n137), .A0N(\permutaion[4][1] ), .A1N(n133), 
        .Y(n225) );
  AOI211X1 U186 ( .A0(n311), .A1(n324), .B0(n138), .C0(rst), .Y(n137) );
  OAI22XL U187 ( .A0(n139), .A1(n39), .B0(n311), .B1(n306), .Y(n138) );
  AOI222XL U188 ( .A0(n316), .A1(\permutaion[0][1] ), .B0(n315), .B1(
        \permutaion[2][1] ), .C0(n310), .C1(\permutaion[1][1] ), .Y(n139) );
  OAI211X1 U189 ( .A0(n40), .A1(n124), .B0(n157), .C0(n98), .Y(n152) );
  NAND3X1 U190 ( .A(N90), .B(n290), .C(n146), .Y(n157) );
  AO22X1 U191 ( .A0(n152), .A1(n153), .B0(\permutaion[5][1] ), .B1(n148), .Y(
        n228) );
  OAI221XL U192 ( .A0(n306), .A1(n316), .B0(n151), .B1(n29), .C0(n154), .Y(
        n153) );
  AOI221XL U193 ( .A0(\permutaion[0][1] ), .A1(n149), .B0(n324), .B1(n316), 
        .C0(rst), .Y(n154) );
  OAI2BB2XL U194 ( .B0(n303), .B1(n147), .A0N(\permutaion[5][2] ), .A1N(n148), 
        .Y(n227) );
  AOI221XL U195 ( .A0(n149), .A1(\permutaion[0][2] ), .B0(n316), .B1(n322), 
        .C0(n150), .Y(n147) );
  OAI22XL U196 ( .A0(n30), .A1(n151), .B0(n316), .B1(n120), .Y(n150) );
  OAI2BB2XL U197 ( .B0(n303), .B1(n155), .A0N(\permutaion[5][0] ), .A1N(n148), 
        .Y(n229) );
  AOI221XL U198 ( .A0(n149), .A1(\permutaion[0][0] ), .B0(n316), .B1(n323), 
        .C0(n156), .Y(n155) );
  OAI22XL U199 ( .A0(n28), .A1(n151), .B0(n316), .B1(n110), .Y(n156) );
  NAND3X1 U200 ( .A(N91), .B(N90), .C(n146), .Y(n173) );
  AO22X1 U201 ( .A0(\permutaion[7][1] ), .A1(n167), .B0(n168), .B1(n170), .Y(
        n234) );
  OAI22XL U202 ( .A0(n315), .A1(n307), .B0(n331), .B1(n136), .Y(n170) );
  AO22X1 U203 ( .A0(\permutaion[7][2] ), .A1(n167), .B0(n168), .B1(n169), .Y(
        n233) );
  OAI22XL U204 ( .A0(n315), .A1(n308), .B0(n332), .B1(n136), .Y(n169) );
  AO22X1 U205 ( .A0(\permutaion[7][0] ), .A1(n167), .B0(n168), .B1(n171), .Y(
        n235) );
  OAI22XL U206 ( .A0(n315), .A1(n294), .B0(n330), .B1(n136), .Y(n171) );
  CLKINVX1 U207 ( .A(n100), .Y(n298) );
  NAND2X1 U208 ( .A(n200), .B(n201), .Y(n180) );
  OAI211XL U209 ( .A0(N96), .A1(n329), .B0(n202), .C0(n54), .Y(n201) );
  OAI21XL U210 ( .A0(N93), .A1(n319), .B0(n205), .Y(n200) );
  OAI22XL U211 ( .A0(\swapTarget[2] ), .A1(n319), .B0(n203), .B1(n204), .Y(
        n202) );
  NAND3X1 U212 ( .A(N91), .B(n289), .C(n146), .Y(n166) );
  OAI2BB2XL U213 ( .B0(n302), .B1(n158), .A0N(\permutaion[6][2] ), .A1N(n159), 
        .Y(n230) );
  AOI2BB2X1 U214 ( .B0(n38), .B1(n160), .A0N(n151), .A1N(n335), .Y(n158) );
  OAI22XL U215 ( .A0(n310), .A1(n308), .B0(n332), .B1(n125), .Y(n160) );
  OAI2BB2XL U216 ( .B0(n302), .B1(n163), .A0N(\permutaion[6][0] ), .A1N(n159), 
        .Y(n232) );
  AOI211X1 U217 ( .A0(n310), .A1(n323), .B0(n165), .C0(rst), .Y(n163) );
  OAI22XL U218 ( .A0(n334), .A1(n151), .B0(n310), .B1(n110), .Y(n165) );
  OAI2BB2XL U219 ( .B0(n302), .B1(n161), .A0N(\permutaion[6][1] ), .A1N(n159), 
        .Y(n231) );
  AOI2BB2X1 U220 ( .B0(n38), .B1(n162), .A0N(n151), .A1N(n333), .Y(n161) );
  OAI22XL U221 ( .A0(n310), .A1(n307), .B0(n331), .B1(n125), .Y(n162) );
  OAI222XL U222 ( .A0(n181), .A1(n182), .B0(n183), .B1(n271), .C0(n2), .C1(n37), .Y(n240) );
  OA21XL U223 ( .A0(n321), .A1(n272), .B0(n185), .Y(n183) );
  OAI222XL U224 ( .A0(n313), .A1(n37), .B0(N87), .B1(n182), .C0(n272), .C1(
        n185), .Y(n241) );
  OAI2BB2XL U225 ( .B0(n34), .B1(n37), .A0N(n199), .A1N(N89), .Y(n249) );
  OAI2BB1X1 U226 ( .A0N(n181), .A1N(n38), .B0(n185), .Y(n199) );
  OAI22XL U227 ( .A0(n290), .A1(n178), .B0(n179), .B1(n271), .Y(n238) );
  CLKINVX1 U228 ( .A(n212), .Y(n292) );
  OAI31XL U229 ( .A0(n293), .A1(n198), .A2(n197), .B0(n336), .Y(n212) );
  CLKINVX1 U230 ( .A(finish), .Y(n293) );
  OAI22XL U231 ( .A0(n291), .A1(n178), .B0(n179), .B1(n320), .Y(n239) );
  OAI22XL U232 ( .A0(n114), .A1(n37), .B0(n34), .B1(n3), .Y(n250) );
  OA21XL U233 ( .A0(n1), .A1(n37), .B0(n187), .Y(n3) );
  AOI211XL U234 ( .A0(N97), .A1(n56), .B0(n57), .C0(N98), .Y(n203) );
  OAI21X1 U235 ( .A0(finish), .A1(n197), .B0(n39), .Y(n190) );
  OAI22XL U236 ( .A0(n313), .A1(n210), .B0(n42), .B1(n37), .Y(n251) );
  NOR2XL U237 ( .A(N97), .B(n56), .Y(n204) );
  OAI221XL U238 ( .A0(n318), .A1(n186), .B0(n295), .B1(n56), .C0(n37), .Y(n244) );
  OAI221XL U239 ( .A0(n317), .A1(n186), .B0(n295), .B1(n57), .C0(n37), .Y(n245) );
  AOI211XL U240 ( .A0(N113), .A1(n307), .B0(n294), .C0(N112), .Y(n195) );
  OAI21XL U241 ( .A0(n295), .A1(n54), .B0(n37), .Y(n242) );
  CLKINVX1 U242 ( .A(N92), .Y(n291) );
  NAND2X1 U243 ( .A(state[0]), .B(n326), .Y(n208) );
  CLKINVX1 U244 ( .A(state[1]), .Y(n326) );
  CLKINVX1 U245 ( .A(\swapTarget[2] ), .Y(n329) );
  NOR2X1 U246 ( .A(n181), .B(N89), .Y(n192) );
  NAND2X1 U247 ( .A(n271), .B(n272), .Y(n181) );
  NOR2X1 U248 ( .A(n326), .B(state[0]), .Y(n198) );
  NOR2X1 U249 ( .A(state[1]), .B(state[0]), .Y(n211) );
  CLKINVX1 U250 ( .A(state[0]), .Y(n328) );
  NOR2X1 U251 ( .A(n42), .B(n41), .Y(n25) );
  OAI221XL U252 ( .A0(\permutaion[5][0] ), .A1(n35), .B0(\permutaion[6][0] ), 
        .B1(n36), .C0(n4), .Y(n21) );
  OAI22XL U253 ( .A0(n1), .A1(n15), .B0(n21), .B1(n2), .Y(N258) );
  OAI221XL U254 ( .A0(\permutaion[5][1] ), .A1(n35), .B0(\permutaion[6][1] ), 
        .B1(n36), .C0(n5), .Y(n23) );
  OAI22XL U255 ( .A0(n1), .A1(n16), .B0(n23), .B1(n2), .Y(N259) );
  OAI221XL U256 ( .A0(\permutaion[5][2] ), .A1(n35), .B0(\permutaion[6][2] ), 
        .B1(n36), .C0(n6), .Y(n27) );
  OAI22XL U257 ( .A0(n1), .A1(n17), .B0(n27), .B1(n2), .Y(N260) );
  AOI222XL U258 ( .A0(\permutaion[0][0] ), .A1(n34), .B0(\permutaion[4][0] ), 
        .B1(n12), .C0(\permutaion[5][0] ), .C1(n11), .Y(n8) );
  AOI222XL U259 ( .A0(\permutaion[1][0] ), .A1(n34), .B0(\permutaion[2][0] ), 
        .B1(n12), .C0(\permutaion[3][0] ), .C1(n11), .Y(n7) );
  OAI22XL U260 ( .A0(n2), .A1(n8), .B0(n1), .B1(n7), .Y(N255) );
  AOI222XL U261 ( .A0(\permutaion[0][1] ), .A1(n34), .B0(\permutaion[4][1] ), 
        .B1(n12), .C0(\permutaion[5][1] ), .C1(n11), .Y(n10) );
  AOI222XL U262 ( .A0(\permutaion[1][1] ), .A1(n34), .B0(\permutaion[2][1] ), 
        .B1(n12), .C0(\permutaion[3][1] ), .C1(n11), .Y(n9) );
  OAI22XL U263 ( .A0(n2), .A1(n10), .B0(n1), .B1(n9), .Y(N256) );
  AOI222XL U264 ( .A0(\permutaion[0][2] ), .A1(n34), .B0(\permutaion[4][2] ), 
        .B1(n12), .C0(\permutaion[5][2] ), .C1(n11), .Y(n14) );
  AOI222XL U265 ( .A0(\permutaion[1][2] ), .A1(n34), .B0(\permutaion[2][2] ), 
        .B1(n12), .C0(\permutaion[3][2] ), .C1(n11), .Y(n13) );
  OAI22XL U266 ( .A0(n2), .A1(n14), .B0(n1), .B1(n13), .Y(N257) );
  NAND2X1 U267 ( .A(n34), .B(n2), .Y(n18) );
  OAI222XL U268 ( .A0(n19), .A1(n28), .B0(n18), .B1(n31), .C0(n15), .C1(n2), 
        .Y(N252) );
  OAI222XL U269 ( .A0(n19), .A1(n29), .B0(n18), .B1(n32), .C0(n16), .C1(n2), 
        .Y(N253) );
  OAI222XL U270 ( .A0(n19), .A1(n30), .B0(n18), .B1(n33), .C0(n17), .C1(n2), 
        .Y(N254) );
  AOI222XL U271 ( .A0(\permutaion[7][0] ), .A1(n41), .B0(\permutaion[3][0] ), 
        .B1(n25), .C0(\permutaion[4][0] ), .C1(n24), .Y(n20) );
  OAI22XL U272 ( .A0(n1), .A1(n21), .B0(n2), .B1(n20), .Y(N112) );
  AOI222XL U273 ( .A0(\permutaion[7][1] ), .A1(n41), .B0(\permutaion[3][1] ), 
        .B1(n25), .C0(\permutaion[4][1] ), .C1(n24), .Y(n22) );
  OAI22XL U274 ( .A0(n1), .A1(n23), .B0(n2), .B1(n22), .Y(N113) );
  AOI222XL U275 ( .A0(\permutaion[7][2] ), .A1(n41), .B0(\permutaion[3][2] ), 
        .B1(n25), .C0(\permutaion[4][2] ), .C1(n24), .Y(n26) );
  OAI22XL U276 ( .A0(n1), .A1(n27), .B0(n26), .B1(n2), .Y(N114) );
  INVXL U277 ( .A(N82), .Y(n63) );
  INVXL U278 ( .A(N81), .Y(n64) );
  NOR2X2 U279 ( .A(n63), .B(N81), .Y(n59) );
  NOR2X1 U280 ( .A(n63), .B(n64), .Y(n58) );
  NOR2X1 U281 ( .A(N81), .B(N82), .Y(n52) );
  AO22X1 U282 ( .A0(\permutaion[5][0] ), .A1(n53), .B0(\permutaion[4][0] ), 
        .B1(n52), .Y(n43) );
  AOI221XL U283 ( .A0(\permutaion[6][0] ), .A1(n59), .B0(\permutaion[7][0] ), 
        .B1(n58), .C0(n43), .Y(n46) );
  AO22X1 U284 ( .A0(\permutaion[1][0] ), .A1(n53), .B0(\permutaion[0][0] ), 
        .B1(n52), .Y(n44) );
  AOI221XL U285 ( .A0(\permutaion[2][0] ), .A1(n59), .B0(\permutaion[3][0] ), 
        .B1(n58), .C0(n44), .Y(n45) );
  OAI22XL U286 ( .A0(n62), .A1(n46), .B0(N83), .B1(n45), .Y(J[0]) );
  AO22X1 U287 ( .A0(\permutaion[5][1] ), .A1(n53), .B0(\permutaion[4][1] ), 
        .B1(n52), .Y(n47) );
  AOI221XL U288 ( .A0(\permutaion[6][1] ), .A1(n59), .B0(\permutaion[7][1] ), 
        .B1(n58), .C0(n47), .Y(n50) );
  AO22X1 U289 ( .A0(\permutaion[1][1] ), .A1(n53), .B0(\permutaion[0][1] ), 
        .B1(n52), .Y(n48) );
  AOI221XL U290 ( .A0(\permutaion[2][1] ), .A1(n59), .B0(\permutaion[3][1] ), 
        .B1(n58), .C0(n48), .Y(n49) );
  OAI22XL U291 ( .A0(n62), .A1(n50), .B0(N83), .B1(n49), .Y(J[1]) );
  AO22X1 U292 ( .A0(\permutaion[5][2] ), .A1(n53), .B0(\permutaion[4][2] ), 
        .B1(n52), .Y(n51) );
  AOI221XL U293 ( .A0(\permutaion[6][2] ), .A1(n59), .B0(\permutaion[7][2] ), 
        .B1(n58), .C0(n51), .Y(n61) );
  AO22X1 U294 ( .A0(\permutaion[1][2] ), .A1(n53), .B0(\permutaion[0][2] ), 
        .B1(n52), .Y(n55) );
  AOI221XL U295 ( .A0(\permutaion[2][2] ), .A1(n59), .B0(\permutaion[3][2] ), 
        .B1(n58), .C0(n55), .Y(n60) );
  NOR2X1 U296 ( .A(n2), .B(n42), .Y(n209) );
  NOR2X1 U297 ( .A(n2), .B(n254), .Y(n77) );
  NOR2X1 U298 ( .A(n254), .B(n1), .Y(n75) );
  NOR2X1 U299 ( .A(n42), .B(n1), .Y(n74) );
  AO22X1 U300 ( .A0(\permutaion[5][0] ), .A1(n75), .B0(\permutaion[4][0] ), 
        .B1(n74), .Y(n65) );
  AOI221XL U301 ( .A0(\permutaion[6][0] ), .A1(n209), .B0(\permutaion[7][0] ), 
        .B1(n77), .C0(n65), .Y(n68) );
  AO22X1 U302 ( .A0(\permutaion[1][0] ), .A1(n75), .B0(\permutaion[0][0] ), 
        .B1(n74), .Y(n66) );
  AOI221XL U303 ( .A0(\permutaion[2][0] ), .A1(n209), .B0(\permutaion[3][0] ), 
        .B1(n77), .C0(n66), .Y(n67) );
  AO22X1 U304 ( .A0(\permutaion[5][1] ), .A1(n75), .B0(\permutaion[4][1] ), 
        .B1(n74), .Y(n69) );
  AOI221XL U305 ( .A0(\permutaion[6][1] ), .A1(n209), .B0(\permutaion[7][1] ), 
        .B1(n77), .C0(n69), .Y(n72) );
  AO22X1 U306 ( .A0(\permutaion[1][1] ), .A1(n75), .B0(\permutaion[0][1] ), 
        .B1(n74), .Y(n70) );
  AOI221XL U307 ( .A0(\permutaion[2][1] ), .A1(n209), .B0(\permutaion[3][1] ), 
        .B1(n77), .C0(n70), .Y(n71) );
  AO22X1 U308 ( .A0(\permutaion[5][2] ), .A1(n75), .B0(\permutaion[4][2] ), 
        .B1(n74), .Y(n73) );
  AOI221XL U309 ( .A0(\permutaion[6][2] ), .A1(n209), .B0(\permutaion[7][2] ), 
        .B1(n77), .C0(n73), .Y(n253) );
  AO22X1 U310 ( .A0(\permutaion[1][2] ), .A1(n75), .B0(\permutaion[0][2] ), 
        .B1(n74), .Y(n76) );
  AOI221XL U311 ( .A0(\permutaion[2][2] ), .A1(n209), .B0(\permutaion[3][2] ), 
        .B1(n77), .C0(n76), .Y(n252) );
  NOR2X1 U312 ( .A(n272), .B(N88), .Y(n265) );
  NOR2X1 U313 ( .A(N87), .B(N88), .Y(n264) );
  AO22X1 U314 ( .A0(\permutaion[5][0] ), .A1(n265), .B0(\permutaion[4][0] ), 
        .B1(n264), .Y(n255) );
  AOI221XL U315 ( .A0(\permutaion[6][0] ), .A1(n268), .B0(\permutaion[7][0] ), 
        .B1(n267), .C0(n255), .Y(n258) );
  AO22X1 U316 ( .A0(\permutaion[1][0] ), .A1(n265), .B0(\permutaion[0][0] ), 
        .B1(n264), .Y(n256) );
  AOI221XL U317 ( .A0(\permutaion[2][0] ), .A1(n268), .B0(\permutaion[3][0] ), 
        .B1(n267), .C0(n256), .Y(n257) );
  OAI22XL U318 ( .A0(n320), .A1(n258), .B0(N89), .B1(n257), .Y(N98) );
  AO22X1 U319 ( .A0(\permutaion[5][1] ), .A1(n265), .B0(\permutaion[4][1] ), 
        .B1(n264), .Y(n259) );
  AOI221XL U320 ( .A0(\permutaion[6][1] ), .A1(n268), .B0(\permutaion[7][1] ), 
        .B1(n267), .C0(n259), .Y(n262) );
  AO22X1 U321 ( .A0(\permutaion[1][1] ), .A1(n265), .B0(\permutaion[0][1] ), 
        .B1(n264), .Y(n260) );
  AOI221XL U322 ( .A0(\permutaion[2][1] ), .A1(n268), .B0(\permutaion[3][1] ), 
        .B1(n267), .C0(n260), .Y(n261) );
  AO22X1 U323 ( .A0(\permutaion[5][2] ), .A1(n265), .B0(\permutaion[4][2] ), 
        .B1(n264), .Y(n263) );
  AOI221XL U324 ( .A0(\permutaion[6][2] ), .A1(n268), .B0(\permutaion[7][2] ), 
        .B1(n267), .C0(n263), .Y(n270) );
  AO22X1 U325 ( .A0(\permutaion[1][2] ), .A1(n265), .B0(\permutaion[0][2] ), 
        .B1(n264), .Y(n266) );
  AOI221XL U326 ( .A0(\permutaion[2][2] ), .A1(n268), .B0(\permutaion[3][2] ), 
        .B1(n267), .C0(n266), .Y(n269) );
  NOR2X1 U327 ( .A(n290), .B(n289), .Y(n285) );
  NOR2X1 U328 ( .A(n289), .B(N91), .Y(n283) );
  NOR2X1 U329 ( .A(N90), .B(N91), .Y(n282) );
  AO22X1 U330 ( .A0(\permutaion[5][0] ), .A1(n283), .B0(\permutaion[4][0] ), 
        .B1(n282), .Y(n273) );
  AOI221XL U331 ( .A0(\permutaion[6][0] ), .A1(n286), .B0(\permutaion[7][0] ), 
        .B1(n285), .C0(n273), .Y(n276) );
  AO22X1 U332 ( .A0(\permutaion[1][0] ), .A1(n283), .B0(\permutaion[0][0] ), 
        .B1(n282), .Y(n274) );
  AOI221XL U333 ( .A0(\permutaion[2][0] ), .A1(n286), .B0(\permutaion[3][0] ), 
        .B1(n285), .C0(n274), .Y(n275) );
  OAI22XL U334 ( .A0(n291), .A1(n276), .B0(N92), .B1(n275), .Y(N135) );
  AO22X1 U335 ( .A0(\permutaion[5][1] ), .A1(n283), .B0(\permutaion[4][1] ), 
        .B1(n282), .Y(n277) );
  AOI221XL U336 ( .A0(\permutaion[6][1] ), .A1(n286), .B0(\permutaion[7][1] ), 
        .B1(n285), .C0(n277), .Y(n280) );
  AO22X1 U337 ( .A0(\permutaion[1][1] ), .A1(n283), .B0(\permutaion[0][1] ), 
        .B1(n282), .Y(n278) );
  AOI221XL U338 ( .A0(\permutaion[2][1] ), .A1(n286), .B0(\permutaion[3][1] ), 
        .B1(n285), .C0(n278), .Y(n279) );
  OAI22XL U339 ( .A0(n291), .A1(n280), .B0(N92), .B1(n279), .Y(N134) );
  AO22X1 U340 ( .A0(\permutaion[5][2] ), .A1(n283), .B0(\permutaion[4][2] ), 
        .B1(n282), .Y(n281) );
  AOI221XL U341 ( .A0(\permutaion[6][2] ), .A1(n286), .B0(\permutaion[7][2] ), 
        .B1(n285), .C0(n281), .Y(n288) );
  AO22X1 U342 ( .A0(\permutaion[1][2] ), .A1(n283), .B0(\permutaion[0][2] ), 
        .B1(n282), .Y(n284) );
  AOI221XL U343 ( .A0(\permutaion[2][2] ), .A1(n286), .B0(\permutaion[3][2] ), 
        .B1(n285), .C0(n284), .Y(n287) );
  OAI22XL U344 ( .A0(n288), .A1(n291), .B0(N92), .B1(n287), .Y(N133) );
endmodule


module accumulator_DW01_add_0 ( A, B, CI, SUM, CO );
  input [10:0] A;
  input [10:0] B;
  output [10:0] SUM;
  input CI;
  output CO;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9;
  wire   [10:1] carry;

  ADDFXL U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(SUM[4])
         );
  ADDFXL U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(SUM[5])
         );
  ADDFXL U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(SUM[6])
         );
  ADDFHX4 U1_1 ( .A(A[1]), .B(B[1]), .CI(n1), .CO(carry[2]), .S(SUM[1]) );
  ADDFHX2 U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(SUM[2])
         );
  AND2X2 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  AND2X2 U2 ( .A(B[9]), .B(n9), .Y(n2) );
  AND2X2 U3 ( .A(B[8]), .B(carry[8]), .Y(n9) );
  NAND2X1 U4 ( .A(A[7]), .B(carry[7]), .Y(n3) );
  NAND2X1 U5 ( .A(B[7]), .B(carry[7]), .Y(n4) );
  NAND2X1 U6 ( .A(B[7]), .B(A[7]), .Y(n5) );
  NAND3X1 U7 ( .A(n3), .B(n4), .C(n5), .Y(carry[8]) );
  XOR3XL U8 ( .A(carry[7]), .B(B[7]), .C(A[7]), .Y(SUM[7]) );
  XOR2XL U9 ( .A(B[8]), .B(carry[8]), .Y(SUM[8]) );
  NAND2X1 U10 ( .A(A[3]), .B(carry[3]), .Y(n6) );
  NAND2X1 U11 ( .A(B[3]), .B(carry[3]), .Y(n7) );
  NAND3X1 U12 ( .A(n6), .B(n7), .C(n8), .Y(carry[4]) );
  XOR3XL U13 ( .A(carry[3]), .B(B[3]), .C(A[3]), .Y(SUM[3]) );
  NAND2X1 U14 ( .A(B[3]), .B(A[3]), .Y(n8) );
  XOR2XL U15 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
  XOR2X1 U16 ( .A(B[10]), .B(n2), .Y(SUM[10]) );
  XOR2X1 U17 ( .A(B[9]), .B(n9), .Y(SUM[9]) );
endmodule


module accumulator ( clk, rst, i_cost, sum_out, o_cost, count, finish );
  input [7:0] i_cost;
  output [10:0] o_cost;
  output [2:0] count;
  input clk, rst, sum_out;
  output finish;
  wire   n12, n13, n14, state, N13, N14, N15, N16, N17, N18, N19, N20, N21,
         N22, N23, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n27,
         n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45,
         n46, n47, n48, n49, n50, n51, n52, n53, n54, n5, n6, n7, n8, n9, n10,
         n11;
  wire   [10:0] cost;

  accumulator_DW01_add_0 add_36 ( .A({1'b0, 1'b0, 1'b0, i_cost}), .B(cost), 
        .CI(1'b0), .SUM({N23, N22, N21, N20, N19, N18, N17, N16, N15, N14, N13}) );
  EDFFTRX1 \o_cost_reg[10]  ( .RN(n11), .D(cost[10]), .E(n6), .CK(clk), .Q(
        o_cost[10]) );
  EDFFTRX1 \o_cost_reg[7]  ( .RN(n11), .D(cost[7]), .E(n6), .CK(clk), .Q(
        o_cost[7]) );
  EDFFTRX1 \o_cost_reg[6]  ( .RN(n11), .D(cost[6]), .E(n6), .CK(clk), .Q(
        o_cost[6]) );
  EDFFTRX1 \o_cost_reg[4]  ( .RN(n11), .D(cost[4]), .E(n6), .CK(clk), .Q(
        o_cost[4]) );
  EDFFTRX1 \o_cost_reg[5]  ( .RN(n11), .D(cost[5]), .E(n6), .CK(clk), .Q(
        o_cost[5]) );
  EDFFTRX1 \o_cost_reg[0]  ( .RN(n11), .D(cost[0]), .E(n6), .CK(clk), .Q(
        o_cost[0]) );
  EDFFTRX1 \o_cost_reg[2]  ( .RN(n11), .D(cost[2]), .E(n6), .CK(clk), .Q(
        o_cost[2]) );
  EDFFTRX1 \o_cost_reg[3]  ( .RN(n11), .D(cost[3]), .E(n6), .CK(clk), .Q(
        o_cost[3]) );
  EDFFTRX1 \o_cost_reg[8]  ( .RN(n11), .D(cost[8]), .E(n6), .CK(clk), .Q(
        o_cost[8]) );
  EDFFTRX1 \o_cost_reg[9]  ( .RN(n11), .D(cost[9]), .E(n6), .CK(clk), .Q(
        o_cost[9]) );
  EDFFTRX1 \o_cost_reg[1]  ( .RN(n11), .D(cost[1]), .E(n6), .CK(clk), .Q(
        o_cost[1]) );
  EDFFX1 finish_reg ( .D(n6), .E(n11), .CK(clk), .Q(finish) );
  EDFFX1 state_reg ( .D(n9), .E(n38), .CK(clk), .Q(state), .QN(n27) );
  DFFQX1 \count_reg[2]  ( .D(n53), .CK(clk), .Q(n12) );
  DFFXL \cost_reg[4]  ( .D(n47), .CK(clk), .Q(cost[4]), .QN(n21) );
  DFFXL \cost_reg[2]  ( .D(n49), .CK(clk), .Q(cost[2]), .QN(n23) );
  DFFXL \cost_reg[0]  ( .D(n51), .CK(clk), .Q(cost[0]), .QN(n25) );
  DFFXL \cost_reg[5]  ( .D(n46), .CK(clk), .Q(cost[5]), .QN(n20) );
  DFFXL \cost_reg[8]  ( .D(n43), .CK(clk), .Q(cost[8]), .QN(n17) );
  DFFXL \cost_reg[9]  ( .D(n42), .CK(clk), .Q(cost[9]), .QN(n16) );
  DFFXL \cost_reg[10]  ( .D(n41), .CK(clk), .Q(cost[10]), .QN(n15) );
  DFFX1 \count_reg[0]  ( .D(n54), .CK(clk), .Q(n14), .QN(n8) );
  DFFX1 \count_reg[1]  ( .D(n52), .CK(clk), .Q(n13), .QN(n10) );
  DFFX1 \cost_reg[3]  ( .D(n48), .CK(clk), .Q(cost[3]), .QN(n22) );
  DFFX1 \cost_reg[7]  ( .D(n44), .CK(clk), .Q(cost[7]), .QN(n18) );
  DFFX1 \cost_reg[1]  ( .D(n50), .CK(clk), .Q(cost[1]), .QN(n24) );
  DFFX1 \cost_reg[6]  ( .D(n45), .CK(clk), .Q(cost[6]), .QN(n19) );
  OAI2BB2XL U3 ( .B0(n15), .B1(n5), .A0N(N23), .A1N(n9), .Y(n41) );
  INVX16 U4 ( .A(n10), .Y(count[1]) );
  INVX16 U5 ( .A(n8), .Y(count[0]) );
  BUFX16 U7 ( .A(n12), .Y(count[2]) );
  CLKBUFX3 U8 ( .A(n34), .Y(n5) );
  OR2X1 U9 ( .A(n35), .B(sum_out), .Y(n34) );
  NAND2X1 U10 ( .A(n9), .B(n39), .Y(n36) );
  INVX3 U11 ( .A(n32), .Y(n9) );
  NAND2X1 U12 ( .A(n11), .B(n32), .Y(n35) );
  OAI221XL U13 ( .A0(n33), .A1(n7), .B0(n32), .B1(n39), .C0(n11), .Y(n38) );
  CLKINVX1 U14 ( .A(sum_out), .Y(n7) );
  NAND2X1 U15 ( .A(n6), .B(n11), .Y(n33) );
  OAI2BB2XL U16 ( .B0(n16), .B1(n5), .A0N(N22), .A1N(n9), .Y(n42) );
  OAI2BB2XL U17 ( .B0(n17), .B1(n5), .A0N(N21), .A1N(n9), .Y(n43) );
  OAI2BB2XL U18 ( .B0(n18), .B1(n5), .A0N(N20), .A1N(n9), .Y(n44) );
  OAI31XL U19 ( .A0(n36), .A1(n8), .A2(n10), .B0(n40), .Y(n53) );
  OAI2BB1XL U20 ( .A0N(n36), .A1N(n37), .B0(count[2]), .Y(n40) );
  NAND2X1 U21 ( .A(n11), .B(n27), .Y(n32) );
  INVX3 U22 ( .A(rst), .Y(n11) );
  OAI2BB2XL U23 ( .B0(n19), .B1(n5), .A0N(N19), .A1N(n9), .Y(n45) );
  OAI32XL U24 ( .A0(n36), .A1(n13), .A2(n8), .B0(n37), .B1(n10), .Y(n52) );
  OAI2BB2XL U25 ( .B0(n20), .B1(n5), .A0N(N18), .A1N(n9), .Y(n46) );
  OAI2BB2XL U26 ( .B0(n21), .B1(n5), .A0N(N17), .A1N(n9), .Y(n47) );
  OAI2BB2XL U27 ( .B0(n22), .B1(n5), .A0N(N16), .A1N(n9), .Y(n48) );
  OAI2BB2XL U28 ( .B0(n23), .B1(n5), .A0N(N15), .A1N(n9), .Y(n49) );
  OAI2BB2XL U29 ( .B0(n24), .B1(n5), .A0N(N14), .A1N(n9), .Y(n50) );
  OAI2BB2XL U30 ( .B0(n25), .B1(n5), .A0N(N13), .A1N(n9), .Y(n51) );
  OAI22XL U31 ( .A0(n35), .A1(n8), .B0(n14), .B1(n36), .Y(n54) );
  CLKBUFX3 U32 ( .A(state), .Y(n6) );
  NAND3XL U33 ( .A(n13), .B(n14), .C(count[2]), .Y(n39) );
  OA21XL U34 ( .A0(n14), .A1(n36), .B0(n35), .Y(n37) );
endmodule


module control_DW01_inc_0_DW01_inc_3 ( A, SUM );
  input [18:0] A;
  output [18:0] SUM;

  wire   [18:2] carry;

  ADDHXL U1_1_17 ( .A(A[17]), .B(carry[17]), .CO(carry[18]), .S(SUM[17]) );
  ADDHXL U1_1_9 ( .A(A[9]), .B(carry[9]), .CO(carry[10]), .S(SUM[9]) );
  ADDHXL U1_1_10 ( .A(A[10]), .B(carry[10]), .CO(carry[11]), .S(SUM[10]) );
  ADDHXL U1_1_7 ( .A(A[7]), .B(carry[7]), .CO(carry[8]), .S(SUM[7]) );
  ADDHXL U1_1_8 ( .A(A[8]), .B(carry[8]), .CO(carry[9]), .S(SUM[8]) );
  ADDHXL U1_1_16 ( .A(A[16]), .B(carry[16]), .CO(carry[17]), .S(SUM[16]) );
  ADDHXL U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHXL U1_1_11 ( .A(A[11]), .B(carry[11]), .CO(carry[12]), .S(SUM[11]) );
  ADDHXL U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ADDHXL U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ADDHXL U1_1_12 ( .A(A[12]), .B(carry[12]), .CO(carry[13]), .S(SUM[12]) );
  ADDHXL U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHXL U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  ADDHXL U1_1_15 ( .A(A[15]), .B(carry[15]), .CO(carry[16]), .S(SUM[15]) );
  ADDHXL U1_1_13 ( .A(A[13]), .B(carry[13]), .CO(carry[14]), .S(SUM[13]) );
  ADDHXL U1_1_14 ( .A(A[14]), .B(carry[14]), .CO(carry[15]), .S(SUM[14]) );
  ADDHXL U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  CLKINVX1 U1 ( .A(A[0]), .Y(SUM[0]) );
  XOR2X1 U2 ( .A(carry[18]), .B(A[18]), .Y(SUM[18]) );
endmodule


module control ( clk, rst, permute_valid, sum_valid, permute_out, sum_out, 
        out_valid, sum_start );
  input clk, rst, permute_valid, sum_valid;
  output permute_out, sum_out, out_valid, sum_start;
  wire   N11, N12, N13, N14, N15, N16, N17, N18, N19, N20, N21, N22, N23, N24,
         N25, N26, N27, N28, N29, n2, n6, n7, n8, n9, n10, n11, n12, n13, n14,
         n15, n16, n17, n18, n19, n20, n21, n22, n27, n3, n5, n24, n25, n26;
  wire   [18:0] count;
  wire   [1:0] state;

  control_DW01_inc_0_DW01_inc_3 add_53 ( .A(count), .SUM({N29, N28, N27, N26, 
        N25, N24, N23, N22, N21, N20, N19, N18, N17, N16, N15, N14, N13, N12, 
        N11}) );
  DFFQX1 sum_start_reg ( .D(n21), .CK(clk), .Q(sum_start) );
  DFFQX1 \state_reg[0]  ( .D(n22), .CK(clk), .Q(state[0]) );
  EDFFX1 \state_reg[1]  ( .D(n10), .E(n11), .CK(clk), .Q(state[1]), .QN(n2) );
  EDFFTRX1 \count_reg[16]  ( .RN(n26), .D(N27), .E(n5), .CK(clk), .Q(count[16]) );
  EDFFTRX1 \count_reg[11]  ( .RN(n26), .D(N22), .E(sum_out), .CK(clk), .Q(
        count[11]) );
  EDFFTRX1 \count_reg[12]  ( .RN(n26), .D(N23), .E(n5), .CK(clk), .Q(count[12]) );
  EDFFTRX1 \count_reg[17]  ( .RN(n26), .D(N28), .E(n5), .CK(clk), .Q(count[17]) );
  EDFFTRX1 \count_reg[15]  ( .RN(n26), .D(N26), .E(sum_out), .CK(clk), .Q(
        count[15]) );
  EDFFTRX1 \count_reg[4]  ( .RN(n26), .D(N15), .E(n5), .CK(clk), .Q(count[4])
         );
  EDFFTRX1 \count_reg[18]  ( .RN(n26), .D(N29), .E(sum_out), .CK(clk), .Q(
        count[18]) );
  EDFFTRX1 \count_reg[5]  ( .RN(n26), .D(N16), .E(n5), .CK(clk), .Q(count[5])
         );
  EDFFTRX1 \count_reg[14]  ( .RN(n26), .D(N25), .E(sum_out), .CK(clk), .Q(
        count[14]) );
  EDFFTRX1 \count_reg[6]  ( .RN(n26), .D(N17), .E(sum_out), .CK(clk), .Q(
        count[6]) );
  EDFFTRX1 \count_reg[13]  ( .RN(n26), .D(N24), .E(n5), .CK(clk), .Q(count[13]) );
  EDFFTRX1 \count_reg[1]  ( .RN(n26), .D(N12), .E(n5), .CK(clk), .Q(count[1])
         );
  EDFFTRX1 \count_reg[2]  ( .RN(n26), .D(N13), .E(sum_out), .CK(clk), .Q(
        count[2]) );
  EDFFTRX1 \count_reg[0]  ( .RN(n26), .D(N11), .E(n5), .CK(clk), .Q(count[0])
         );
  EDFFTRX1 \count_reg[3]  ( .RN(n26), .D(N14), .E(sum_out), .CK(clk), .Q(
        count[3]) );
  EDFFTRX1 \count_reg[10]  ( .RN(n26), .D(N21), .E(sum_out), .CK(clk), .Q(
        count[10]) );
  EDFFTRX1 \count_reg[8]  ( .RN(n26), .D(N19), .E(n5), .CK(clk), .Q(count[8])
         );
  EDFFTRX1 \count_reg[9]  ( .RN(n26), .D(N20), .E(n5), .CK(clk), .Q(count[9])
         );
  EDFFTRX1 \count_reg[7]  ( .RN(n26), .D(N18), .E(sum_out), .CK(clk), .Q(
        count[7]) );
  OR4X1 U3 ( .A(n14), .B(n15), .C(n16), .D(n17), .Y(n27) );
  INVX12 U4 ( .A(n27), .Y(out_valid) );
  OR2X1 U5 ( .A(n2), .B(state[0]), .Y(n3) );
  AND2X2 U6 ( .A(sum_out), .B(n26), .Y(n7) );
  CLKINVX1 U7 ( .A(n9), .Y(permute_out) );
  INVX3 U8 ( .A(n3), .Y(sum_out) );
  INVX3 U9 ( .A(n3), .Y(n5) );
  NAND4X1 U10 ( .A(count[11]), .B(count[12]), .C(n19), .D(count[15]), .Y(n15)
         );
  NAND4X1 U11 ( .A(count[0]), .B(count[1]), .C(count[2]), .D(count[3]), .Y(n17) );
  NAND4X1 U12 ( .A(count[4]), .B(count[5]), .C(n18), .D(count[6]), .Y(n16) );
  OR4X1 U13 ( .A(count[16]), .B(count[17]), .C(n20), .D(count[18]), .Y(n14) );
  OR2X1 U14 ( .A(count[9]), .B(count[7]), .Y(n20) );
  AND2X2 U15 ( .A(count[10]), .B(count[8]), .Y(n18) );
  NOR2X1 U16 ( .A(count[14]), .B(count[13]), .Y(n19) );
  OAI211X1 U17 ( .A0(n9), .A1(n25), .B0(n13), .C0(n6), .Y(n11) );
  CLKINVX1 U18 ( .A(permute_valid), .Y(n25) );
  NAND2X1 U19 ( .A(sum_valid), .B(n10), .Y(n13) );
  NOR2X1 U20 ( .A(rst), .B(n7), .Y(n6) );
  OAI21XL U21 ( .A0(n11), .A1(n24), .B0(n12), .Y(n22) );
  OAI21XL U22 ( .A0(permute_out), .A1(rst), .B0(n11), .Y(n12) );
  INVX3 U23 ( .A(rst), .Y(n26) );
  NOR3X1 U24 ( .A(rst), .B(state[1]), .C(permute_out), .Y(n10) );
  OAI2BB2XL U25 ( .B0(n8), .B1(n9), .A0N(sum_start), .A1N(n8), .Y(n21) );
  AOI31X1 U26 ( .A0(permute_valid), .A1(n26), .A2(permute_out), .B0(n10), .Y(
        n8) );
  NAND2X1 U27 ( .A(n24), .B(n2), .Y(n9) );
  CLKINVX1 U28 ( .A(state[0]), .Y(n24) );
endmodule


module result ( clk, rst, sumFinish, i_sum, matchCount, minCost );
  input [10:0] i_sum;
  output [3:0] matchCount;
  output [10:0] minCost;
  input clk, rst, sumFinish;
  wire   n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100, n101,
         n102, n103, N3, N4, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17,
         n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31,
         n32, n1, n3, n5, n7, n37, n39, n41, n43, n45, n47, n49, n51, n53, n54,
         n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68,
         n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82,
         n83, n84, n85, n86, n87, n88;

  DFFSX1 \minCost_reg[6]  ( .D(n27), .CK(n55), .SN(n88), .Q(n97), .QN(n51) );
  DFFSX1 \minCost_reg[0]  ( .D(n32), .CK(n55), .SN(n88), .Q(n103), .QN(n49) );
  DFFRX1 \minCost_reg[10]  ( .D(n31), .CK(n55), .RN(n88), .Q(n93), .QN(n47) );
  DFFSX1 \minCost_reg[9]  ( .D(n30), .CK(n55), .SN(n88), .Q(n94), .QN(n45) );
  DFFSX1 \minCost_reg[8]  ( .D(n29), .CK(n55), .SN(n88), .Q(n95), .QN(n43) );
  DFFSX1 \minCost_reg[3]  ( .D(n24), .CK(n55), .SN(n88), .Q(n100), .QN(n41) );
  DFFSX1 \minCost_reg[2]  ( .D(n23), .CK(n55), .SN(n88), .Q(n101), .QN(n39) );
  DFFSX1 \minCost_reg[1]  ( .D(n22), .CK(n55), .SN(n88), .Q(n102), .QN(n37) );
  DFFSX1 \minCost_reg[4]  ( .D(n25), .CK(n55), .SN(n88), .Q(n99), .QN(n7) );
  DFFRX1 \matchCount_reg[3]  ( .D(n18), .CK(n55), .RN(n88), .Q(n89), .QN(n5)
         );
  DFFSX1 \minCost_reg[7]  ( .D(n28), .CK(n55), .SN(n88), .Q(n96), .QN(n3) );
  DFFSX1 \minCost_reg[5]  ( .D(n26), .CK(n55), .SN(n88), .Q(n98), .QN(n1) );
  DFFRX1 \matchCount_reg[2]  ( .D(n19), .CK(n55), .RN(n88), .Q(n90), .QN(n8)
         );
  DFFRX1 \matchCount_reg[0]  ( .D(n21), .CK(n55), .RN(n88), .Q(n92), .QN(n10)
         );
  DFFRX1 \matchCount_reg[1]  ( .D(n20), .CK(n55), .RN(n88), .Q(n91), .QN(n9)
         );
  INVX12 U3 ( .A(n1), .Y(minCost[5]) );
  INVX12 U4 ( .A(n3), .Y(minCost[7]) );
  INVX12 U5 ( .A(n5), .Y(matchCount[3]) );
  INVX12 U6 ( .A(n7), .Y(minCost[4]) );
  INVX12 U7 ( .A(n9), .Y(matchCount[1]) );
  INVX12 U8 ( .A(n10), .Y(matchCount[0]) );
  INVX12 U9 ( .A(n8), .Y(matchCount[2]) );
  INVX12 U10 ( .A(n37), .Y(minCost[1]) );
  INVX12 U11 ( .A(n39), .Y(minCost[2]) );
  INVX12 U12 ( .A(n41), .Y(minCost[3]) );
  INVX12 U13 ( .A(n43), .Y(minCost[8]) );
  INVX12 U14 ( .A(n45), .Y(minCost[9]) );
  INVX12 U15 ( .A(n47), .Y(minCost[10]) );
  OAI2BB1XL U16 ( .A0N(n85), .A1N(n93), .B0(n66), .Y(N3) );
  OAI211XL U17 ( .A0(n93), .A1(n85), .B0(n65), .C0(n75), .Y(n66) );
  INVX12 U18 ( .A(n49), .Y(minCost[0]) );
  INVX12 U19 ( .A(n51), .Y(minCost[6]) );
  NAND2BXL U20 ( .AN(i_sum[5]), .B(n98), .Y(n60) );
  AOI32XL U21 ( .A0(n86), .A1(n71), .A2(n59), .B0(n99), .B1(n82), .Y(n61) );
  NOR2BXL U22 ( .AN(i_sum[5]), .B(n98), .Y(n67) );
  NOR2XL U23 ( .A(n83), .B(n97), .Y(n69) );
  NOR2XL U24 ( .A(n82), .B(n99), .Y(n68) );
  NOR2BXL U25 ( .AN(n103), .B(i_sum[0]), .Y(n57) );
  NOR2BXL U26 ( .AN(i_sum[0]), .B(n103), .Y(n73) );
  OR2XL U27 ( .A(n96), .B(n84), .Y(n76) );
  OAI211XL U28 ( .A0(n93), .A1(n85), .B0(n78), .C0(n77), .Y(n79) );
  CLKINVX1 U29 ( .A(n68), .Y(n86) );
  NAND2X1 U30 ( .A(n54), .B(n14), .Y(n17) );
  CLKBUFX3 U31 ( .A(n87), .Y(n54) );
  CLKINVX1 U32 ( .A(n53), .Y(n87) );
  OAI221XL U33 ( .A0(n92), .A1(n14), .B0(n10), .B1(n17), .C0(n54), .Y(n21) );
  OAI32XL U34 ( .A0(n9), .A1(n90), .A2(n13), .B0(n15), .B1(n8), .Y(n19) );
  INVX3 U35 ( .A(rst), .Y(n88) );
  OAI22XL U36 ( .A0(n16), .A1(n9), .B0(n91), .B1(n13), .Y(n20) );
  NAND2X1 U37 ( .A(N4), .B(n54), .Y(n14) );
  OA21XL U38 ( .A0(n91), .A1(n14), .B0(n16), .Y(n15) );
  OA21XL U39 ( .A0(n92), .A1(n14), .B0(n17), .Y(n16) );
  AO22X1 U40 ( .A0(i_sum[4]), .A1(n53), .B0(n99), .B1(n54), .Y(n25) );
  AO22X1 U41 ( .A0(i_sum[5]), .A1(n53), .B0(n98), .B1(n54), .Y(n26) );
  AO22X1 U42 ( .A0(i_sum[6]), .A1(n53), .B0(n97), .B1(n54), .Y(n27) );
  AO22X1 U43 ( .A0(i_sum[0]), .A1(n53), .B0(n103), .B1(n54), .Y(n32) );
  AO22X1 U44 ( .A0(i_sum[7]), .A1(n53), .B0(n96), .B1(n54), .Y(n28) );
  AO22X1 U45 ( .A0(i_sum[9]), .A1(n53), .B0(n94), .B1(n54), .Y(n30) );
  AO22X1 U46 ( .A0(i_sum[8]), .A1(n53), .B0(n95), .B1(n54), .Y(n29) );
  AO22X1 U47 ( .A0(i_sum[3]), .A1(n53), .B0(n100), .B1(n54), .Y(n24) );
  AO22X1 U48 ( .A0(i_sum[2]), .A1(n53), .B0(n101), .B1(n54), .Y(n23) );
  AO22X1 U49 ( .A0(i_sum[1]), .A1(n53), .B0(n102), .B1(n54), .Y(n22) );
  AO22X1 U50 ( .A0(i_sum[10]), .A1(n53), .B0(n93), .B1(n54), .Y(n31) );
  OAI2BB1XL U51 ( .A0N(n89), .A1N(n11), .B0(n12), .Y(n18) );
  OR4XL U52 ( .A(n89), .B(n8), .C(n9), .D(n13), .Y(n12) );
  OAI21XL U53 ( .A0(n90), .A1(n14), .B0(n15), .Y(n11) );
  OR2X1 U54 ( .A(n14), .B(n10), .Y(n13) );
  CLKBUFX3 U55 ( .A(N3), .Y(n53) );
  CLKINVX1 U56 ( .A(i_sum[10]), .Y(n85) );
  BUFX4 U57 ( .A(sumFinish), .Y(n55) );
  CLKINVX1 U58 ( .A(i_sum[1]), .Y(n81) );
  CLKINVX1 U59 ( .A(i_sum[4]), .Y(n82) );
  CLKINVX1 U60 ( .A(i_sum[6]), .Y(n83) );
  CLKINVX1 U61 ( .A(i_sum[7]), .Y(n84) );
  NAND2X1 U62 ( .A(i_sum[3]), .B(n41), .Y(n71) );
  OAI2BB1X1 U63 ( .A0N(n81), .A1N(n57), .B0(n37), .Y(n56) );
  NAND2X1 U64 ( .A(i_sum[2]), .B(n39), .Y(n72) );
  OAI211X1 U65 ( .A0(n57), .A1(n81), .B0(n56), .C0(n72), .Y(n58) );
  OAI221XL U66 ( .A0(i_sum[2]), .A1(n39), .B0(i_sum[3]), .B1(n41), .C0(n58), 
        .Y(n59) );
  AOI211X1 U67 ( .A0(n61), .A1(n60), .B0(n67), .C0(n69), .Y(n62) );
  AOI221XL U68 ( .A0(n96), .A1(n84), .B0(n97), .B1(n83), .C0(n62), .Y(n64) );
  NAND2X1 U69 ( .A(i_sum[8]), .B(n43), .Y(n74) );
  NAND2X1 U70 ( .A(n76), .B(n74), .Y(n63) );
  OAI222XL U71 ( .A0(n64), .A1(n63), .B0(i_sum[8]), .B1(n43), .C0(i_sum[9]), 
        .C1(n45), .Y(n65) );
  NAND2X1 U72 ( .A(i_sum[9]), .B(n45), .Y(n75) );
  NOR3X1 U73 ( .A(n69), .B(n68), .C(n67), .Y(n70) );
  NAND4BX1 U74 ( .AN(n53), .B(n72), .C(n71), .D(n70), .Y(n80) );
  OAI22XL U75 ( .A0(i_sum[1]), .A1(n73), .B0(n73), .B1(n37), .Y(n78) );
  AND3X1 U76 ( .A(n76), .B(n75), .C(n74), .Y(n77) );
  NOR2X1 U77 ( .A(n80), .B(n79), .Y(N4) );
endmodule


module JAM ( CLK, RST, W, J, Cost, MatchCount, MinCost, Valid );
  output [2:0] W;
  output [2:0] J;
  input [7:0] Cost;
  output [3:0] MatchCount;
  output [10:0] MinCost;
  input CLK, RST;
  output Valid;
  wire   n7, n8, n9, permute_valid, sum_start, sum_out, sumFinish, n1, n3, n5;
  wire   [10:0] totalCost;

  permute permute ( .W(W), .clk(CLK), .rst(RST), .finish(sum_start), .valid(
        permute_valid), .J({n7, n8, n9}) );
  accumulator accumulator ( .clk(CLK), .rst(RST), .i_cost(Cost), .sum_out(
        sum_out), .o_cost(totalCost), .count(W), .finish(sumFinish) );
  control control ( .clk(CLK), .rst(RST), .permute_valid(permute_valid), 
        .sum_valid(sumFinish), .sum_out(sum_out), .out_valid(Valid), 
        .sum_start(sum_start) );
  result result ( .clk(CLK), .rst(RST), .sumFinish(sumFinish), .i_sum(
        totalCost), .matchCount(MatchCount), .minCost(MinCost) );
  INVX12 U1 ( .A(n3), .Y(J[0]) );
  CLKINVX1 U2 ( .A(n9), .Y(n3) );
  INVX12 U3 ( .A(n5), .Y(J[1]) );
  CLKINVX1 U4 ( .A(n8), .Y(n5) );
  INVX12 U5 ( .A(n1), .Y(J[2]) );
  CLKINVX1 U6 ( .A(n7), .Y(n1) );
endmodule

