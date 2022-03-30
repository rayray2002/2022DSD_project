/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : R-2020.09-SP5
// Date      : Wed Mar 30 17:01:32 2022
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
         N135, N252, N253, N254, N255, N256, N257, N258, N259, N260, n52, n54,
         n55, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88,
         n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100, n101,
         n102, n103, n104, n105, n106, n107, n108, n109, n110, n111, n112,
         n113, n114, n115, n116, n117, n118, n119, n120, n121, n122, n123,
         n124, n125, n126, n127, n128, n129, n130, n131, n132, n133, n134,
         n135, n136, n137, n138, n139, n140, n141, n142, n143, n144, n145,
         n146, n147, n148, n149, n150, n151, n152, n153, n154, n155, n156,
         n157, n158, n159, n160, n161, n162, n163, n164, n165, n166, n167,
         n168, n169, n170, n171, n172, n173, n174, n175, n176, n177, n178,
         n179, n180, n181, n182, n183, n184, n185, n186, n187, n188, n189,
         n190, n191, n192, n193, n194, n195, n196, n197, n198, n199, n200,
         n201, n202, n203, n204, n205, n206, n208, n209, n210, n211, n212,
         n213, n214, n215, n216, n217, n218, n219, n220, n221, n222, n223,
         n224, n225, n226, n227, n228, n229, n230, n231, n232, n233, n234,
         n235, n236, n237, n238, n239, n240, n241, n242, n243, n244, n245,
         n246, n247, n248, n249, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11,
         n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25,
         n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39,
         n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n53, n56,
         n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70,
         n71, n72, n73, n74, n75, n207, n250, n251, n252, n253, n254, n255,
         n256, n257, n258, n259, n260, n261, n262, n263, n264, n265, n266,
         n267, n268, n269, n270, n271, n272, n273, n274, n275, n276, n277,
         n278, n279, n280, n281, n282, n283, n284, n285, n286, n287, n288,
         n289, n290, n291, n292, n293, n294, n295, n296, n297, n298, n299,
         n300, n301, n302, n303, n304, n305, n306, n307, n308, n309, n310,
         n311, n312, n313, n314, n315, n316, n317, n318, n319, n320, n321,
         n322, n323, n324, n325, n326, n327, n328, n329, n330, n331, n332,
         n333, n334, n335, n336, n337, n338;
  wire   [1:0] state;
  assign N81 = W[0];
  assign N82 = W[1];
  assign N83 = W[2];
  assign valid = 1'b0;

  DFFQX1 \state_reg[1]  ( .D(n246), .CK(clk), .Q(state[1]) );
  DFFX1 \swapTarget_reg[3]  ( .D(n240), .CK(clk), .QN(n52) );
  DFFQX1 \state_reg[0]  ( .D(n245), .CK(clk), .Q(state[0]) );
  DFFQX1 \swapTarget_reg[2]  ( .D(n243), .CK(clk), .Q(\swapTarget[2] ) );
  DFFX1 \swapTarget_reg[0]  ( .D(n242), .CK(clk), .QN(n55) );
  DFFX1 \swapTarget_reg[1]  ( .D(n241), .CK(clk), .QN(n54) );
  DFFQX1 \pivotIndex_reg[2]  ( .D(n248), .CK(clk), .Q(N86) );
  DFFX1 \index_reg[1]  ( .D(n238), .CK(clk), .Q(N88), .QN(n275) );
  DFFQX1 \permutaion_reg[6][2]  ( .D(n228), .CK(clk), .Q(\permutaion[6][2] )
         );
  DFFQX1 \permutaion_reg[7][2]  ( .D(n231), .CK(clk), .Q(\permutaion[7][2] )
         );
  DFFQX1 \permutaion_reg[6][1]  ( .D(n229), .CK(clk), .Q(\permutaion[6][1] )
         );
  DFFQX1 \permutaion_reg[6][0]  ( .D(n230), .CK(clk), .Q(\permutaion[6][0] )
         );
  DFFQX1 \pivotIndex_reg[0]  ( .D(n249), .CK(clk), .Q(N84) );
  DFFQX1 \permutaion_reg[7][1]  ( .D(n232), .CK(clk), .Q(\permutaion[7][1] )
         );
  DFFQX1 \permutaion_reg[7][0]  ( .D(n233), .CK(clk), .Q(\permutaion[7][0] )
         );
  DFFQX1 \permutaion_reg[5][2]  ( .D(n225), .CK(clk), .Q(\permutaion[5][2] )
         );
  DFFQX1 \permutaion_reg[5][1]  ( .D(n226), .CK(clk), .Q(\permutaion[5][1] )
         );
  DFFQX1 \permutaion_reg[5][0]  ( .D(n227), .CK(clk), .Q(\permutaion[5][0] )
         );
  DFFQX1 \swapIndex_reg[2]  ( .D(n237), .CK(clk), .Q(N92) );
  DFFQX1 \index_reg[2]  ( .D(n247), .CK(clk), .Q(N89) );
  DFFX4 \pivotIndex_reg[1]  ( .D(n244), .CK(clk), .Q(n1), .QN(n2) );
  DFFX1 \index_reg[0]  ( .D(n239), .CK(clk), .Q(N87), .QN(n276) );
  DFFX1 \permutaion_reg[2][1]  ( .D(n217), .CK(clk), .Q(\permutaion[2][1] ), 
        .QN(n34) );
  DFFX1 \permutaion_reg[2][0]  ( .D(n218), .CK(clk), .Q(\permutaion[2][0] ), 
        .QN(n33) );
  DFFX1 \permutaion_reg[2][2]  ( .D(n216), .CK(clk), .Q(\permutaion[2][2] ), 
        .QN(n35) );
  DFFX1 \permutaion_reg[0][0]  ( .D(n212), .CK(clk), .Q(\permutaion[0][0] ), 
        .QN(n336) );
  DFFX2 \permutaion_reg[3][1]  ( .D(n220), .CK(clk), .Q(\permutaion[3][1] ) );
  DFFX2 \permutaion_reg[3][0]  ( .D(n221), .CK(clk), .Q(\permutaion[3][0] ) );
  DFFX2 \permutaion_reg[3][2]  ( .D(n219), .CK(clk), .Q(\permutaion[3][2] ) );
  DFFX2 \permutaion_reg[0][1]  ( .D(n211), .CK(clk), .Q(\permutaion[0][1] ), 
        .QN(n335) );
  DFFX2 \permutaion_reg[0][2]  ( .D(n234), .CK(clk), .Q(\permutaion[0][2] ), 
        .QN(n337) );
  DFFX2 \permutaion_reg[4][1]  ( .D(n223), .CK(clk), .Q(\permutaion[4][1] ) );
  DFFX2 \permutaion_reg[4][0]  ( .D(n224), .CK(clk), .Q(\permutaion[4][0] ) );
  DFFX2 \permutaion_reg[4][2]  ( .D(n222), .CK(clk), .Q(\permutaion[4][2] ) );
  DFFX2 \swapIndex_reg[0]  ( .D(n235), .CK(clk), .Q(N90), .QN(n294) );
  DFFX2 \swapIndex_reg[1]  ( .D(n236), .CK(clk), .Q(N91), .QN(n295) );
  DFFX1 \permutaion_reg[1][1]  ( .D(n214), .CK(clk), .Q(\permutaion[1][1] ), 
        .QN(n31) );
  DFFX1 \permutaion_reg[1][0]  ( .D(n215), .CK(clk), .Q(\permutaion[1][0] ), 
        .QN(n30) );
  DFFX1 \permutaion_reg[1][2]  ( .D(n213), .CK(clk), .Q(\permutaion[1][2] ), 
        .QN(n32) );
  CLKINVX1 U3 ( .A(n39), .Y(n60) );
  NAND2BX1 U4 ( .AN(n68), .B(n67), .Y(n39) );
  NAND3X1 U5 ( .A(n2), .B(n36), .C(n46), .Y(n89) );
  OAI211X1 U6 ( .A0(n42), .A1(n89), .B0(n98), .C0(n99), .Y(n86) );
  OAI32X1 U7 ( .A0(N90), .A1(N91), .A2(n301), .B0(n79), .B1(n42), .Y(n175) );
  OAI222XL U8 ( .A0(\permutaion[4][2] ), .A1(n38), .B0(\permutaion[3][2] ), 
        .B1(n37), .C0(\permutaion[0][2] ), .C1(n45), .Y(n19) );
  OAI222XL U9 ( .A0(\permutaion[4][1] ), .A1(n38), .B0(\permutaion[3][1] ), 
        .B1(n37), .C0(\permutaion[0][1] ), .C1(n45), .Y(n18) );
  OAI211X1 U10 ( .A0(n42), .A1(n102), .B0(n98), .C0(n110), .Y(n103) );
  AOI221XL U11 ( .A0(\permutaion[6][0] ), .A1(n63), .B0(\permutaion[7][0] ), 
        .B1(n62), .C0(n47), .Y(n50) );
  AOI221XL U12 ( .A0(\permutaion[6][1] ), .A1(n63), .B0(\permutaion[7][1] ), 
        .B1(n62), .C0(n51), .Y(n57) );
  AOI221XL U13 ( .A0(\permutaion[6][2] ), .A1(n63), .B0(\permutaion[7][2] ), 
        .B1(n62), .C0(n58), .Y(n65) );
  CLKBUFX3 U14 ( .A(N86), .Y(n45) );
  NOR2X2 U15 ( .A(n295), .B(N90), .Y(n291) );
  OAI222XL U16 ( .A0(\permutaion[4][0] ), .A1(n38), .B0(\permutaion[3][0] ), 
        .B1(n37), .C0(\permutaion[0][0] ), .C1(n45), .Y(n17) );
  AOI221XL U17 ( .A0(\permutaion[2][0] ), .A1(n63), .B0(\permutaion[3][0] ), 
        .B1(n62), .C0(n48), .Y(n49) );
  AOI221XL U18 ( .A0(\permutaion[2][1] ), .A1(n63), .B0(\permutaion[3][1] ), 
        .B1(n62), .C0(n53), .Y(n56) );
  NOR2XL U19 ( .A(n179), .B(N89), .Y(n192) );
  INVX3 U20 ( .A(n45), .Y(n36) );
  NOR2X2 U21 ( .A(n314), .B(n45), .Y(n26) );
  NOR2X2 U22 ( .A(n67), .B(N81), .Y(n63) );
  INVX1 U23 ( .A(N82), .Y(n67) );
  OAI22X1 U24 ( .A0(n274), .A1(n277), .B0(N89), .B1(n273), .Y(N96) );
  NOR2X2 U25 ( .A(n36), .B(n314), .Y(n13) );
  OAI22X1 U26 ( .A0(n277), .A1(n266), .B0(N89), .B1(n265), .Y(N97) );
  NOR2X2 U27 ( .A(n36), .B(n46), .Y(n14) );
  OAI22X1 U28 ( .A0(n36), .A1(n72), .B0(n45), .B1(n71), .Y(N95) );
  INVXL U29 ( .A(N81), .Y(n68) );
  NOR2X1 U30 ( .A(N81), .B(N82), .Y(n59) );
  AO22X1 U31 ( .A0(\permutaion[1][2] ), .A1(n60), .B0(\permutaion[0][2] ), 
        .B1(n59), .Y(n61) );
  OAI211XL U32 ( .A0(n42), .A1(n112), .B0(n98), .C0(n143), .Y(n139) );
  INVXL U33 ( .A(N97), .Y(n320) );
  INVXL U34 ( .A(n178), .Y(n299) );
  NAND3XL U35 ( .A(n46), .B(n2), .C(n45), .Y(n121) );
  NAND2XL U36 ( .A(n45), .B(n2), .Y(n21) );
  CLKINVX1 U37 ( .A(n76), .Y(n300) );
  AOI32XL U38 ( .A0(n100), .A1(n294), .A2(N91), .B0(n43), .B1(n111), .Y(n110)
         );
  AOI32XL U39 ( .A0(n100), .A1(n295), .A2(N90), .B0(n43), .B1(n101), .Y(n99)
         );
  OAI211XL U40 ( .A0(n42), .A1(n113), .B0(n98), .C0(n128), .Y(n125) );
  AOI31XL U41 ( .A0(N90), .A1(n100), .A2(N91), .B0(n43), .Y(n128) );
  OAI211XL U42 ( .A0(n42), .A1(n133), .B0(n171), .C0(n98), .Y(n170) );
  OAI211XL U43 ( .A0(n42), .A1(n44), .B0(n154), .C0(n98), .Y(n152) );
  OAI211XL U44 ( .A0(n42), .A1(n122), .B0(n164), .C0(n98), .Y(n162) );
  OAI32XL U45 ( .A0(n40), .A1(n1), .A2(n314), .B0(n185), .B1(n2), .Y(n244) );
  AOI22XL U46 ( .A0(n27), .A1(n31), .B0(n26), .B1(n34), .Y(n7) );
  AOI22XL U47 ( .A0(n27), .A1(n30), .B0(n26), .B1(n33), .Y(n6) );
  AOI22XL U48 ( .A0(n27), .A1(n32), .B0(n26), .B1(n35), .Y(n8) );
  OAI22X1 U49 ( .A0(n36), .A1(n207), .B0(n45), .B1(n75), .Y(N94) );
  CLKINVX1 U50 ( .A(N93), .Y(n310) );
  CLKINVX1 U51 ( .A(n41), .Y(n324) );
  NAND2X1 U52 ( .A(N133), .B(n41), .Y(n91) );
  NOR3X1 U53 ( .A(n43), .B(rst), .C(n175), .Y(n76) );
  CLKBUFX3 U54 ( .A(N84), .Y(n46) );
  CLKBUFX3 U55 ( .A(n95), .Y(n41) );
  BUFX4 U56 ( .A(n80), .Y(n43) );
  AND2X2 U57 ( .A(\permutaion[2][2] ), .B(n63), .Y(n3) );
  AND2X2 U58 ( .A(\permutaion[3][2] ), .B(n62), .Y(n4) );
  NOR3X1 U59 ( .A(n3), .B(n4), .C(n61), .Y(n64) );
  INVX1 U60 ( .A(n13), .Y(n38) );
  CLKINVX1 U61 ( .A(n124), .Y(n313) );
  OAI31X1 U62 ( .A0(n138), .A1(n318), .A2(n328), .B0(n139), .Y(n130) );
  CLKINVX1 U63 ( .A(n139), .Y(n307) );
  NOR2X1 U64 ( .A(n324), .B(n310), .Y(n88) );
  NOR2X1 U65 ( .A(n324), .B(n309), .Y(n78) );
  CLKINVX1 U66 ( .A(n142), .Y(n308) );
  CLKINVX1 U67 ( .A(n160), .Y(n316) );
  CLKINVX1 U68 ( .A(n85), .Y(n326) );
  CLKINVX1 U69 ( .A(n40), .Y(n323) );
  CLKINVX1 U70 ( .A(n188), .Y(n296) );
  CLKINVX1 U71 ( .A(n184), .Y(n298) );
  NAND2X1 U72 ( .A(n296), .B(n40), .Y(n208) );
  INVX1 U73 ( .A(n14), .Y(n37) );
  NAND2X1 U74 ( .A(n112), .B(n44), .Y(n124) );
  INVX3 U75 ( .A(n122), .Y(n311) );
  CLKINVX1 U76 ( .A(n112), .Y(n312) );
  CLKINVX1 U77 ( .A(n44), .Y(n318) );
  INVX3 U78 ( .A(n133), .Y(n317) );
  NAND3X1 U79 ( .A(n2), .B(n36), .C(n314), .Y(n79) );
  NAND2X1 U80 ( .A(n122), .B(n133), .Y(n138) );
  CLKINVX1 U81 ( .A(n113), .Y(n315) );
  CLKINVX1 U82 ( .A(n86), .Y(n304) );
  CLKINVX1 U83 ( .A(n103), .Y(n303) );
  OAI22XL U84 ( .A0(n86), .A1(n30), .B0(n304), .B1(n94), .Y(n215) );
  AOI22X1 U85 ( .A0(n41), .A1(n96), .B0(N255), .B1(n43), .Y(n94) );
  OAI2BB2XL U86 ( .B0(n331), .B1(n89), .A0N(n89), .A1N(N95), .Y(n96) );
  OAI22XL U87 ( .A0(n86), .A1(n31), .B0(n304), .B1(n92), .Y(n214) );
  AOI221XL U88 ( .A0(n78), .A1(n89), .B0(N256), .B1(n43), .C0(n93), .Y(n92) );
  OAI21XL U89 ( .A0(n82), .A1(n89), .B0(n338), .Y(n93) );
  OAI22XL U90 ( .A0(n86), .A1(n32), .B0(n304), .B1(n87), .Y(n213) );
  AOI221XL U91 ( .A0(n88), .A1(n89), .B0(N257), .B1(n43), .C0(n90), .Y(n87) );
  OAI21XL U92 ( .A0(n89), .A1(n91), .B0(n338), .Y(n90) );
  OAI22XL U93 ( .A0(n103), .A1(n33), .B0(n303), .B1(n108), .Y(n218) );
  AOI221XL U94 ( .A0(n308), .A1(n102), .B0(N252), .B1(n43), .C0(n109), .Y(n108) );
  OAI21XL U95 ( .A0(n85), .A1(n102), .B0(n338), .Y(n109) );
  OAI22XL U96 ( .A0(n103), .A1(n34), .B0(n303), .B1(n106), .Y(n217) );
  AOI22X1 U97 ( .A0(n41), .A1(n107), .B0(N253), .B1(n43), .Y(n106) );
  OAI2BB2XL U98 ( .B0(n332), .B1(n102), .A0N(n102), .A1N(N94), .Y(n107) );
  OAI22XL U99 ( .A0(n103), .A1(n35), .B0(n303), .B1(n104), .Y(n216) );
  AOI221XL U100 ( .A0(n88), .A1(n102), .B0(N254), .B1(n43), .C0(n105), .Y(n104) );
  OAI21XL U101 ( .A0(n91), .A1(n102), .B0(n338), .Y(n105) );
  CLKBUFX3 U102 ( .A(n97), .Y(n42) );
  NAND3X1 U103 ( .A(n192), .B(n178), .C(n41), .Y(n97) );
  OAI22XL U104 ( .A0(n300), .A1(n337), .B0(n76), .B1(n173), .Y(n234) );
  AOI221XL U105 ( .A0(n88), .A1(n79), .B0(N260), .B1(n43), .C0(n174), .Y(n173)
         );
  OAI21XL U106 ( .A0(n79), .A1(n91), .B0(n338), .Y(n174) );
  OAI22XL U107 ( .A0(n300), .A1(n336), .B0(n76), .B1(n83), .Y(n212) );
  AOI221XL U108 ( .A0(n308), .A1(n79), .B0(N258), .B1(n43), .C0(n84), .Y(n83)
         );
  OAI21XL U109 ( .A0(n79), .A1(n85), .B0(n338), .Y(n84) );
  OAI22XL U110 ( .A0(n300), .A1(n335), .B0(n76), .B1(n77), .Y(n211) );
  AOI221XL U111 ( .A0(n78), .A1(n79), .B0(N259), .B1(n43), .C0(n81), .Y(n77)
         );
  OAI21XL U112 ( .A0(n79), .A1(n82), .B0(n338), .Y(n81) );
  AOI31X1 U113 ( .A0(n294), .A1(n295), .A2(n144), .B0(n43), .Y(n143) );
  NOR2X1 U114 ( .A(n334), .B(n42), .Y(n144) );
  OAI22XL U115 ( .A0(N96), .A1(n310), .B0(n204), .B1(n205), .Y(n203) );
  NOR2XL U116 ( .A(N94), .B(n320), .Y(n205) );
  AOI211XL U117 ( .A0(N94), .A1(n320), .B0(n319), .C0(N95), .Y(n204) );
  OAI31X1 U118 ( .A0(n124), .A1(n311), .A2(n328), .B0(n125), .Y(n115) );
  CLKINVX1 U119 ( .A(n46), .Y(n258) );
  OAI31X1 U120 ( .A0(n324), .A1(n299), .A2(n192), .B0(n40), .Y(n183) );
  NAND2X1 U121 ( .A(n41), .B(n183), .Y(n180) );
  NOR2BX1 U122 ( .AN(n170), .B(n324), .Y(n166) );
  OAI21X1 U123 ( .A0(n317), .A1(n328), .B0(n162), .Y(n156) );
  OAI21X1 U124 ( .A0(n328), .A1(n138), .B0(n152), .Y(n146) );
  NAND2X1 U125 ( .A(n328), .B(n170), .Y(n165) );
  CLKINVX1 U126 ( .A(n162), .Y(n305) );
  CLKINVX1 U127 ( .A(n152), .Y(n306) );
  CLKINVX1 U128 ( .A(n125), .Y(n302) );
  OAI21X1 U129 ( .A0(n324), .A1(n178), .B0(n296), .Y(n176) );
  NAND2X1 U130 ( .A(n41), .B(n176), .Y(n177) );
  OAI22XL U131 ( .A0(n294), .A1(n176), .B0(n177), .B1(n276), .Y(n235) );
  CLKBUFX3 U132 ( .A(n182), .Y(n40) );
  NAND2X1 U133 ( .A(n209), .B(n338), .Y(n182) );
  NAND2X1 U134 ( .A(N134), .B(n41), .Y(n82) );
  NAND2XL U135 ( .A(N95), .B(n41), .Y(n142) );
  NAND2X1 U136 ( .A(n317), .B(n43), .Y(n160) );
  INVXL U137 ( .A(N96), .Y(n321) );
  NAND2X1 U138 ( .A(N135), .B(n41), .Y(n85) );
  INVX3 U139 ( .A(n43), .Y(n328) );
  NAND2X1 U140 ( .A(n311), .B(n43), .Y(n148) );
  NAND4X1 U141 ( .A(n296), .B(n190), .C(n42), .D(n328), .Y(n186) );
  NAND2X1 U142 ( .A(n323), .B(n193), .Y(n190) );
  OAI21XL U143 ( .A0(N114), .A1(n310), .B0(n194), .Y(n193) );
  OAI2BB2XL U144 ( .B0(n195), .B1(n196), .A0N(n310), .A1N(N114), .Y(n194) );
  OAI21XL U145 ( .A0(n329), .A1(n186), .B0(n187), .Y(n245) );
  OAI21XL U146 ( .A0(n41), .A1(n188), .B0(n186), .Y(n187) );
  NAND2X1 U147 ( .A(n338), .B(n210), .Y(n188) );
  NAND4BX1 U148 ( .AN(n209), .B(finish), .C(n206), .D(n191), .Y(n210) );
  OAI221XL U149 ( .A0(n321), .A1(n184), .B0(n298), .B1(n330), .C0(n40), .Y(
        n243) );
  NAND2X1 U150 ( .A(n299), .B(n41), .Y(n184) );
  INVX1 U151 ( .A(N94), .Y(n309) );
  OA21XL U152 ( .A0(n46), .A1(n40), .B0(n208), .Y(n185) );
  NOR2X1 U153 ( .A(N113), .B(n309), .Y(n196) );
  INVXL U154 ( .A(N95), .Y(n297) );
  CLKINVX1 U155 ( .A(N98), .Y(n319) );
  INVX1 U156 ( .A(N134), .Y(n332) );
  INVX1 U157 ( .A(N135), .Y(n331) );
  INVXL U158 ( .A(N133), .Y(n333) );
  NAND3X2 U159 ( .A(n314), .B(n2), .C(n45), .Y(n112) );
  INVX3 U160 ( .A(n46), .Y(n314) );
  CLKBUFX3 U161 ( .A(n121), .Y(n44) );
  NAND3X2 U162 ( .A(n1), .B(n36), .C(n46), .Y(n113) );
  NAND3X2 U163 ( .A(n314), .B(n36), .C(n1), .Y(n102) );
  NAND3X2 U164 ( .A(n1), .B(n314), .C(n45), .Y(n122) );
  NAND3X2 U165 ( .A(n46), .B(n1), .C(n45), .Y(n133) );
  OAI22XL U166 ( .A0(n65), .A1(n66), .B0(N83), .B1(n64), .Y(J[2]) );
  INVXL U167 ( .A(N83), .Y(n66) );
  NAND2X1 U168 ( .A(n313), .B(n102), .Y(n101) );
  NAND2X1 U169 ( .A(n112), .B(n113), .Y(n111) );
  NOR2X1 U170 ( .A(n42), .B(N92), .Y(n100) );
  NOR2X1 U171 ( .A(n206), .B(rst), .Y(n95) );
  CLKINVX1 U172 ( .A(n100), .Y(n301) );
  OAI2BB2XL U173 ( .B0(n307), .B1(n137), .A0N(\permutaion[4][0] ), .A1N(n130), 
        .Y(n224) );
  AOI211X1 U174 ( .A0(n312), .A1(n326), .B0(n140), .C0(rst), .Y(n137) );
  OAI22XL U175 ( .A0(n141), .A1(n328), .B0(n312), .B1(n142), .Y(n140) );
  AOI222XL U176 ( .A0(n318), .A1(\permutaion[0][0] ), .B0(n317), .B1(
        \permutaion[2][0] ), .C0(n311), .C1(\permutaion[1][0] ), .Y(n141) );
  OAI2BB2XL U177 ( .B0(n307), .B1(n134), .A0N(\permutaion[4][1] ), .A1N(n130), 
        .Y(n223) );
  AOI211X1 U178 ( .A0(n312), .A1(n327), .B0(n135), .C0(rst), .Y(n134) );
  CLKINVX1 U179 ( .A(n82), .Y(n327) );
  OAI2BB2XL U180 ( .B0(n136), .B1(n328), .A0N(n112), .A1N(n78), .Y(n135) );
  OAI2BB2XL U181 ( .B0(n307), .B1(n129), .A0N(\permutaion[4][2] ), .A1N(n130), 
        .Y(n222) );
  AOI22X1 U182 ( .A0(n41), .A1(n131), .B0(n43), .B1(n132), .Y(n129) );
  OAI222XL U183 ( .A0(n32), .A1(n122), .B0(n35), .B1(n133), .C0(n44), .C1(n337), .Y(n132) );
  OAI22XL U184 ( .A0(n312), .A1(n310), .B0(n333), .B1(n112), .Y(n131) );
  NOR2BX2 U185 ( .AN(n172), .B(rst), .Y(n98) );
  NAND4X1 U186 ( .A(n313), .B(n43), .C(n113), .D(n102), .Y(n172) );
  NOR2X1 U187 ( .A(n191), .B(rst), .Y(n80) );
  NAND2X1 U188 ( .A(n198), .B(n199), .Y(n178) );
  OAI211XL U189 ( .A0(N96), .A1(n330), .B0(n200), .C0(n52), .Y(n199) );
  OAI21XL U190 ( .A0(N93), .A1(n321), .B0(n203), .Y(n198) );
  OAI22XL U191 ( .A0(\swapTarget[2] ), .A1(n321), .B0(n201), .B1(n202), .Y(
        n200) );
  OAI2BB2XL U192 ( .B0(n302), .B1(n114), .A0N(\permutaion[3][2] ), .A1N(n115), 
        .Y(n219) );
  AOI211X1 U193 ( .A0(n315), .A1(n325), .B0(n116), .C0(rst), .Y(n114) );
  CLKINVX1 U194 ( .A(n91), .Y(n325) );
  OAI2BB2XL U195 ( .B0(n117), .B1(n328), .A0N(n113), .A1N(n88), .Y(n116) );
  OAI2BB2XL U196 ( .B0(n302), .B1(n123), .A0N(\permutaion[3][0] ), .A1N(n115), 
        .Y(n221) );
  AOI22X1 U197 ( .A0(n41), .A1(n126), .B0(n43), .B1(n127), .Y(n123) );
  OAI222XL U198 ( .A0(n30), .A1(n44), .B0(n33), .B1(n122), .C0(n336), .C1(n112), .Y(n127) );
  OAI22XL U199 ( .A0(n315), .A1(n297), .B0(n331), .B1(n113), .Y(n126) );
  OAI2BB2XL U200 ( .B0(n302), .B1(n118), .A0N(\permutaion[3][1] ), .A1N(n115), 
        .Y(n220) );
  AOI22X1 U201 ( .A0(n41), .A1(n119), .B0(n43), .B1(n120), .Y(n118) );
  OAI222XL U202 ( .A0(n31), .A1(n44), .B0(n34), .B1(n122), .C0(n335), .C1(n112), .Y(n120) );
  OAI22XL U203 ( .A0(n315), .A1(n309), .B0(n332), .B1(n113), .Y(n119) );
  OAI222XL U204 ( .A0(n179), .A1(n180), .B0(n181), .B1(n275), .C0(n2), .C1(n40), .Y(n238) );
  OA21XL U205 ( .A0(n324), .A1(n276), .B0(n183), .Y(n181) );
  OAI222XL U206 ( .A0(n314), .A1(n40), .B0(N87), .B1(n180), .C0(n276), .C1(
        n183), .Y(n239) );
  NAND3X1 U207 ( .A(N91), .B(N90), .C(n144), .Y(n171) );
  AO22X1 U208 ( .A0(\permutaion[7][1] ), .A1(n165), .B0(n166), .B1(n168), .Y(
        n232) );
  OAI22XL U209 ( .A0(n317), .A1(n309), .B0(n332), .B1(n133), .Y(n168) );
  AO22X1 U210 ( .A0(\permutaion[7][0] ), .A1(n165), .B0(n166), .B1(n169), .Y(
        n233) );
  OAI22XL U211 ( .A0(n317), .A1(n297), .B0(n331), .B1(n133), .Y(n169) );
  AO22X1 U212 ( .A0(\permutaion[7][2] ), .A1(n165), .B0(n166), .B1(n167), .Y(
        n231) );
  OAI22XL U213 ( .A0(n317), .A1(n310), .B0(n333), .B1(n133), .Y(n167) );
  NAND3X1 U214 ( .A(N91), .B(n294), .C(n144), .Y(n164) );
  NAND3X1 U215 ( .A(N90), .B(n295), .C(n144), .Y(n154) );
  OAI2BB2XL U216 ( .B0(n305), .B1(n161), .A0N(\permutaion[6][0] ), .A1N(n156), 
        .Y(n230) );
  AOI211X1 U217 ( .A0(n311), .A1(n326), .B0(n163), .C0(rst), .Y(n161) );
  OAI22XL U218 ( .A0(n336), .A1(n160), .B0(n311), .B1(n142), .Y(n163) );
  OAI2BB2XL U219 ( .B0(n306), .B1(n145), .A0N(\permutaion[5][2] ), .A1N(n146), 
        .Y(n225) );
  AOI221XL U220 ( .A0(n88), .A1(n44), .B0(n316), .B1(\permutaion[1][2] ), .C0(
        n147), .Y(n145) );
  OAI22XL U221 ( .A0(n91), .A1(n44), .B0(n337), .B1(n148), .Y(n147) );
  OAI2BB2XL U222 ( .B0(n306), .B1(n151), .A0N(\permutaion[5][0] ), .A1N(n146), 
        .Y(n227) );
  AOI221XL U223 ( .A0(n308), .A1(n44), .B0(n316), .B1(\permutaion[1][0] ), 
        .C0(n153), .Y(n151) );
  OAI22XL U224 ( .A0(n85), .A1(n44), .B0(n336), .B1(n148), .Y(n153) );
  OAI2BB2XL U225 ( .B0(n306), .B1(n149), .A0N(\permutaion[5][1] ), .A1N(n146), 
        .Y(n226) );
  AOI221XL U226 ( .A0(n78), .A1(n44), .B0(n316), .B1(\permutaion[1][1] ), .C0(
        n150), .Y(n149) );
  OAI221XL U227 ( .A0(n335), .A1(n148), .B0(n82), .B1(n44), .C0(n338), .Y(n150) );
  OAI2BB2XL U228 ( .B0(n305), .B1(n155), .A0N(\permutaion[6][2] ), .A1N(n156), 
        .Y(n228) );
  AOI22X1 U229 ( .A0(n41), .A1(n157), .B0(n316), .B1(\permutaion[0][2] ), .Y(
        n155) );
  OAI22XL U230 ( .A0(n311), .A1(n310), .B0(n333), .B1(n122), .Y(n157) );
  OAI2BB2XL U231 ( .B0(n305), .B1(n158), .A0N(\permutaion[6][1] ), .A1N(n156), 
        .Y(n229) );
  AOI22X1 U232 ( .A0(n41), .A1(n159), .B0(n316), .B1(\permutaion[0][1] ), .Y(
        n158) );
  OAI22XL U233 ( .A0(n311), .A1(n309), .B0(n332), .B1(n122), .Y(n159) );
  OAI2BB2XL U234 ( .B0(n36), .B1(n40), .A0N(n197), .A1N(N89), .Y(n247) );
  OAI2BB1X1 U235 ( .A0N(n179), .A1N(n41), .B0(n183), .Y(n197) );
  OAI22XL U236 ( .A0(n295), .A1(n176), .B0(n177), .B1(n275), .Y(n236) );
  OAI22XL U237 ( .A0(n334), .A1(n176), .B0(n177), .B1(n277), .Y(n237) );
  AOI211XL U238 ( .A0(N97), .A1(n54), .B0(n55), .C0(N98), .Y(n201) );
  INVX3 U239 ( .A(rst), .Y(n338) );
  OAI21XL U240 ( .A0(n322), .A1(n186), .B0(n189), .Y(n246) );
  CLKINVX1 U241 ( .A(state[1]), .Y(n322) );
  OAI21XL U242 ( .A0(n323), .A1(n41), .B0(n186), .Y(n189) );
  AOI211XL U243 ( .A0(N113), .A1(n309), .B0(n297), .C0(N112), .Y(n195) );
  OAI22XL U244 ( .A0(n113), .A1(n40), .B0(n36), .B1(n5), .Y(n248) );
  OA21XL U245 ( .A0(n1), .A1(n40), .B0(n185), .Y(n5) );
  NOR2XL U246 ( .A(N97), .B(n54), .Y(n202) );
  OAI221XL U247 ( .A0(n320), .A1(n184), .B0(n298), .B1(n54), .C0(n40), .Y(n241) );
  OAI221XL U248 ( .A0(n319), .A1(n184), .B0(n298), .B1(n55), .C0(n40), .Y(n242) );
  OAI21XL U249 ( .A0(n298), .A1(n52), .B0(n40), .Y(n240) );
  OAI22XL U250 ( .A0(n314), .A1(n208), .B0(n46), .B1(n40), .Y(n249) );
  CLKINVX1 U251 ( .A(N89), .Y(n277) );
  NAND2X1 U252 ( .A(state[1]), .B(n329), .Y(n206) );
  CLKINVX1 U253 ( .A(state[0]), .Y(n329) );
  CLKINVX1 U254 ( .A(\swapTarget[2] ), .Y(n330) );
  NAND2X1 U255 ( .A(n275), .B(n276), .Y(n179) );
  NAND2X1 U256 ( .A(state[1]), .B(state[0]), .Y(n191) );
  AOI222XL U257 ( .A0(n318), .A1(\permutaion[0][1] ), .B0(n317), .B1(
        \permutaion[2][1] ), .C0(n311), .C1(\permutaion[1][1] ), .Y(n136) );
  AOI222XL U258 ( .A0(\permutaion[0][2] ), .A1(n312), .B0(n311), .B1(
        \permutaion[2][2] ), .C0(n318), .C1(\permutaion[1][2] ), .Y(n117) );
  NOR2X1 U259 ( .A(n329), .B(state[1]), .Y(n209) );
  CLKINVX1 U260 ( .A(N92), .Y(n334) );
  NOR2X1 U261 ( .A(n46), .B(n45), .Y(n27) );
  OAI221XL U262 ( .A0(\permutaion[5][0] ), .A1(n37), .B0(\permutaion[6][0] ), 
        .B1(n38), .C0(n6), .Y(n23) );
  OAI22XL U263 ( .A0(n1), .A1(n17), .B0(n23), .B1(n2), .Y(N258) );
  OAI221XL U264 ( .A0(\permutaion[5][1] ), .A1(n37), .B0(\permutaion[6][1] ), 
        .B1(n38), .C0(n7), .Y(n25) );
  OAI22XL U265 ( .A0(n1), .A1(n18), .B0(n25), .B1(n2), .Y(N259) );
  OAI221XL U266 ( .A0(\permutaion[5][2] ), .A1(n37), .B0(\permutaion[6][2] ), 
        .B1(n38), .C0(n8), .Y(n29) );
  OAI22XL U267 ( .A0(n1), .A1(n19), .B0(n29), .B1(n2), .Y(N260) );
  AOI222XL U268 ( .A0(\permutaion[0][0] ), .A1(n36), .B0(\permutaion[4][0] ), 
        .B1(n14), .C0(\permutaion[5][0] ), .C1(n13), .Y(n10) );
  AOI222XL U269 ( .A0(\permutaion[1][0] ), .A1(n36), .B0(\permutaion[2][0] ), 
        .B1(n14), .C0(\permutaion[3][0] ), .C1(n13), .Y(n9) );
  OAI22XL U270 ( .A0(n2), .A1(n10), .B0(n1), .B1(n9), .Y(N255) );
  AOI222XL U271 ( .A0(\permutaion[0][1] ), .A1(n36), .B0(\permutaion[4][1] ), 
        .B1(n14), .C0(\permutaion[5][1] ), .C1(n13), .Y(n12) );
  AOI222XL U272 ( .A0(\permutaion[1][1] ), .A1(n36), .B0(\permutaion[2][1] ), 
        .B1(n14), .C0(\permutaion[3][1] ), .C1(n13), .Y(n11) );
  OAI22XL U273 ( .A0(n2), .A1(n12), .B0(n1), .B1(n11), .Y(N256) );
  AOI222XL U274 ( .A0(\permutaion[0][2] ), .A1(n36), .B0(\permutaion[4][2] ), 
        .B1(n14), .C0(\permutaion[5][2] ), .C1(n13), .Y(n16) );
  AOI222XL U275 ( .A0(\permutaion[1][2] ), .A1(n36), .B0(\permutaion[2][2] ), 
        .B1(n14), .C0(\permutaion[3][2] ), .C1(n13), .Y(n15) );
  OAI22XL U276 ( .A0(n2), .A1(n16), .B0(n1), .B1(n15), .Y(N257) );
  NAND2X1 U277 ( .A(n36), .B(n2), .Y(n20) );
  OAI222XL U278 ( .A0(n21), .A1(n30), .B0(n20), .B1(n33), .C0(n17), .C1(n2), 
        .Y(N252) );
  OAI222XL U279 ( .A0(n21), .A1(n31), .B0(n20), .B1(n34), .C0(n18), .C1(n2), 
        .Y(N253) );
  OAI222XL U280 ( .A0(n21), .A1(n32), .B0(n20), .B1(n35), .C0(n19), .C1(n2), 
        .Y(N254) );
  AOI222XL U281 ( .A0(\permutaion[7][0] ), .A1(n45), .B0(\permutaion[3][0] ), 
        .B1(n27), .C0(\permutaion[4][0] ), .C1(n26), .Y(n22) );
  OAI22XL U282 ( .A0(n1), .A1(n23), .B0(n2), .B1(n22), .Y(N112) );
  AOI222XL U283 ( .A0(\permutaion[7][1] ), .A1(n45), .B0(\permutaion[3][1] ), 
        .B1(n27), .C0(\permutaion[4][1] ), .C1(n26), .Y(n24) );
  OAI22XL U284 ( .A0(n1), .A1(n25), .B0(n2), .B1(n24), .Y(N113) );
  AOI222XL U285 ( .A0(\permutaion[7][2] ), .A1(n45), .B0(\permutaion[3][2] ), 
        .B1(n27), .C0(\permutaion[4][2] ), .C1(n26), .Y(n28) );
  OAI22XL U286 ( .A0(n1), .A1(n29), .B0(n28), .B1(n2), .Y(N114) );
  NOR2X2 U287 ( .A(n68), .B(n67), .Y(n62) );
  AO22X1 U288 ( .A0(\permutaion[5][0] ), .A1(n60), .B0(\permutaion[4][0] ), 
        .B1(n59), .Y(n47) );
  AO22X1 U289 ( .A0(\permutaion[1][0] ), .A1(n60), .B0(\permutaion[0][0] ), 
        .B1(n59), .Y(n48) );
  OAI22XL U290 ( .A0(n66), .A1(n50), .B0(N83), .B1(n49), .Y(J[0]) );
  AO22X1 U291 ( .A0(\permutaion[5][1] ), .A1(n60), .B0(\permutaion[4][1] ), 
        .B1(n59), .Y(n51) );
  AO22X1 U292 ( .A0(\permutaion[1][1] ), .A1(n60), .B0(\permutaion[0][1] ), 
        .B1(n59), .Y(n53) );
  OAI22XL U293 ( .A0(n66), .A1(n57), .B0(N83), .B1(n56), .Y(J[1]) );
  AO22X1 U294 ( .A0(\permutaion[5][2] ), .A1(n60), .B0(\permutaion[4][2] ), 
        .B1(n59), .Y(n58) );
  NOR2X1 U295 ( .A(n2), .B(n46), .Y(n255) );
  NOR2X1 U296 ( .A(n2), .B(n258), .Y(n254) );
  NOR2X1 U297 ( .A(n258), .B(n1), .Y(n252) );
  NOR2X1 U298 ( .A(n46), .B(n1), .Y(n251) );
  AO22X1 U299 ( .A0(\permutaion[5][0] ), .A1(n252), .B0(\permutaion[4][0] ), 
        .B1(n251), .Y(n69) );
  AOI221XL U300 ( .A0(\permutaion[6][0] ), .A1(n255), .B0(\permutaion[7][0] ), 
        .B1(n254), .C0(n69), .Y(n72) );
  AO22X1 U301 ( .A0(\permutaion[1][0] ), .A1(n252), .B0(\permutaion[0][0] ), 
        .B1(n251), .Y(n70) );
  AOI221XL U302 ( .A0(\permutaion[2][0] ), .A1(n255), .B0(\permutaion[3][0] ), 
        .B1(n254), .C0(n70), .Y(n71) );
  AO22X1 U303 ( .A0(\permutaion[5][1] ), .A1(n252), .B0(\permutaion[4][1] ), 
        .B1(n251), .Y(n73) );
  AOI221XL U304 ( .A0(\permutaion[6][1] ), .A1(n255), .B0(\permutaion[7][1] ), 
        .B1(n254), .C0(n73), .Y(n207) );
  AO22X1 U305 ( .A0(\permutaion[1][1] ), .A1(n252), .B0(\permutaion[0][1] ), 
        .B1(n251), .Y(n74) );
  AOI221XL U306 ( .A0(\permutaion[2][1] ), .A1(n255), .B0(\permutaion[3][1] ), 
        .B1(n254), .C0(n74), .Y(n75) );
  AO22X1 U307 ( .A0(\permutaion[5][2] ), .A1(n252), .B0(\permutaion[4][2] ), 
        .B1(n251), .Y(n250) );
  AOI221XL U308 ( .A0(\permutaion[6][2] ), .A1(n255), .B0(\permutaion[7][2] ), 
        .B1(n254), .C0(n250), .Y(n257) );
  AO22X1 U309 ( .A0(\permutaion[1][2] ), .A1(n252), .B0(\permutaion[0][2] ), 
        .B1(n251), .Y(n253) );
  AOI221XL U310 ( .A0(\permutaion[2][2] ), .A1(n255), .B0(\permutaion[3][2] ), 
        .B1(n254), .C0(n253), .Y(n256) );
  OAI22XL U311 ( .A0(n257), .A1(n36), .B0(n45), .B1(n256), .Y(N93) );
  NOR2X1 U312 ( .A(n275), .B(N87), .Y(n272) );
  NOR2X1 U313 ( .A(n275), .B(n276), .Y(n271) );
  NOR2X1 U314 ( .A(n276), .B(N88), .Y(n269) );
  NOR2X1 U315 ( .A(N87), .B(N88), .Y(n268) );
  AO22X1 U316 ( .A0(\permutaion[5][0] ), .A1(n269), .B0(\permutaion[4][0] ), 
        .B1(n268), .Y(n259) );
  AOI221XL U317 ( .A0(\permutaion[6][0] ), .A1(n272), .B0(\permutaion[7][0] ), 
        .B1(n271), .C0(n259), .Y(n262) );
  AO22X1 U318 ( .A0(\permutaion[1][0] ), .A1(n269), .B0(\permutaion[0][0] ), 
        .B1(n268), .Y(n260) );
  AOI221XL U319 ( .A0(\permutaion[2][0] ), .A1(n272), .B0(\permutaion[3][0] ), 
        .B1(n271), .C0(n260), .Y(n261) );
  OAI22XL U320 ( .A0(n277), .A1(n262), .B0(N89), .B1(n261), .Y(N98) );
  AO22X1 U321 ( .A0(\permutaion[5][1] ), .A1(n269), .B0(\permutaion[4][1] ), 
        .B1(n268), .Y(n263) );
  AOI221XL U322 ( .A0(\permutaion[6][1] ), .A1(n272), .B0(\permutaion[7][1] ), 
        .B1(n271), .C0(n263), .Y(n266) );
  AO22X1 U323 ( .A0(\permutaion[1][1] ), .A1(n269), .B0(\permutaion[0][1] ), 
        .B1(n268), .Y(n264) );
  AOI221XL U324 ( .A0(\permutaion[2][1] ), .A1(n272), .B0(\permutaion[3][1] ), 
        .B1(n271), .C0(n264), .Y(n265) );
  AO22X1 U325 ( .A0(\permutaion[5][2] ), .A1(n269), .B0(\permutaion[4][2] ), 
        .B1(n268), .Y(n267) );
  AOI221XL U326 ( .A0(\permutaion[6][2] ), .A1(n272), .B0(\permutaion[7][2] ), 
        .B1(n271), .C0(n267), .Y(n274) );
  AO22X1 U327 ( .A0(\permutaion[1][2] ), .A1(n269), .B0(\permutaion[0][2] ), 
        .B1(n268), .Y(n270) );
  AOI221XL U328 ( .A0(\permutaion[2][2] ), .A1(n272), .B0(\permutaion[3][2] ), 
        .B1(n271), .C0(n270), .Y(n273) );
  NOR2X1 U329 ( .A(n295), .B(n294), .Y(n290) );
  NOR2X1 U330 ( .A(n294), .B(N91), .Y(n288) );
  NOR2X1 U331 ( .A(N90), .B(N91), .Y(n287) );
  AO22X1 U332 ( .A0(\permutaion[5][0] ), .A1(n288), .B0(\permutaion[4][0] ), 
        .B1(n287), .Y(n278) );
  AOI221XL U333 ( .A0(\permutaion[6][0] ), .A1(n291), .B0(\permutaion[7][0] ), 
        .B1(n290), .C0(n278), .Y(n281) );
  AO22X1 U334 ( .A0(\permutaion[1][0] ), .A1(n288), .B0(\permutaion[0][0] ), 
        .B1(n287), .Y(n279) );
  AOI221XL U335 ( .A0(\permutaion[2][0] ), .A1(n291), .B0(\permutaion[3][0] ), 
        .B1(n290), .C0(n279), .Y(n280) );
  OAI22XL U336 ( .A0(n334), .A1(n281), .B0(N92), .B1(n280), .Y(N135) );
  AO22X1 U337 ( .A0(\permutaion[5][1] ), .A1(n288), .B0(\permutaion[4][1] ), 
        .B1(n287), .Y(n282) );
  AOI221XL U338 ( .A0(\permutaion[6][1] ), .A1(n291), .B0(\permutaion[7][1] ), 
        .B1(n290), .C0(n282), .Y(n285) );
  AO22X1 U339 ( .A0(\permutaion[1][1] ), .A1(n288), .B0(\permutaion[0][1] ), 
        .B1(n287), .Y(n283) );
  AOI221XL U340 ( .A0(\permutaion[2][1] ), .A1(n291), .B0(\permutaion[3][1] ), 
        .B1(n290), .C0(n283), .Y(n284) );
  OAI22XL U341 ( .A0(n334), .A1(n285), .B0(N92), .B1(n284), .Y(N134) );
  AO22X1 U342 ( .A0(\permutaion[5][2] ), .A1(n288), .B0(\permutaion[4][2] ), 
        .B1(n287), .Y(n286) );
  AOI221XL U343 ( .A0(\permutaion[6][2] ), .A1(n291), .B0(\permutaion[7][2] ), 
        .B1(n290), .C0(n286), .Y(n293) );
  AO22X1 U344 ( .A0(\permutaion[1][2] ), .A1(n288), .B0(\permutaion[0][2] ), 
        .B1(n287), .Y(n289) );
  AOI221XL U345 ( .A0(\permutaion[2][2] ), .A1(n291), .B0(\permutaion[3][2] ), 
        .B1(n290), .C0(n289), .Y(n292) );
  OAI22XL U346 ( .A0(n293), .A1(n334), .B0(N92), .B1(n292), .Y(N133) );
endmodule


module accumulator_DW01_add_0 ( A, B, CI, SUM, CO );
  input [10:0] A;
  input [10:0] B;
  output [10:0] SUM;
  input CI;
  output CO;
  wire   n1, n2, n3;
  wire   [10:1] carry;

  ADDFXL U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(SUM[5])
         );
  ADDFXL U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(SUM[4])
         );
  ADDFXL U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(SUM[3])
         );
  ADDFXL U1_1 ( .A(A[1]), .B(B[1]), .CI(n1), .CO(carry[2]), .S(SUM[1]) );
  ADDFXL U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(carry[8]), .S(SUM[7])
         );
  ADDFXL U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(SUM[2])
         );
  ADDFX2 U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(SUM[6])
         );
  AND2X2 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2XL U2 ( .A(B[9]), .B(n2), .Y(SUM[9]) );
  XOR2XL U3 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
  XNOR2X1 U4 ( .A(B[10]), .B(n3), .Y(SUM[10]) );
  NAND2X1 U5 ( .A(B[9]), .B(n2), .Y(n3) );
  AND2X2 U6 ( .A(B[8]), .B(carry[8]), .Y(n2) );
  XOR2X1 U7 ( .A(B[8]), .B(carry[8]), .Y(SUM[8]) );
endmodule


module accumulator ( clk, rst, count8, i_cost, i_count, o_cost, count9, finish
 );
  input [7:0] i_cost;
  input [2:0] i_count;
  output [10:0] o_cost;
  input clk, rst, count8;
  output count9, finish;
  wire   n6, N3, N4, N5, N6, N7, N8, N9, N10, N11, N12, N13, N14, N15, N16,
         N17, N18, N19, N20, N21, N38, n4, n2, n5;
  wire   [10:0] cost;

  accumulator_DW01_add_0 add_27 ( .A({1'b0, 1'b0, 1'b0, i_cost}), .B(cost), 
        .CI(1'b0), .SUM({N13, N12, N11, N10, N9, N8, N7, N6, N5, N4, N3}) );
  DFFTRX1 \cost_reg[10]  ( .D(N13), .RN(n2), .CK(clk), .Q(cost[10]) );
  DFFTRX1 \cost_reg[9]  ( .D(N12), .RN(n2), .CK(clk), .Q(cost[9]) );
  DFFTRX1 \cost_reg[8]  ( .D(N11), .RN(n2), .CK(clk), .Q(cost[8]) );
  DFFQX1 \cost_reg[7]  ( .D(N21), .CK(clk), .Q(cost[7]) );
  DFFTRX1 count9_reg ( .D(n5), .RN(count8), .CK(clk), .Q(n6) );
  DFFTRX1 finish_reg ( .D(count9), .RN(n5), .CK(clk), .Q(finish) );
  DFFQX1 \cost_reg[6]  ( .D(N20), .CK(clk), .Q(cost[6]) );
  DFFQX1 \cost_reg[5]  ( .D(N19), .CK(clk), .Q(cost[5]) );
  DFFQX1 \cost_reg[4]  ( .D(N18), .CK(clk), .Q(cost[4]) );
  DFFQX1 \cost_reg[3]  ( .D(N17), .CK(clk), .Q(cost[3]) );
  DFFQX1 \cost_reg[2]  ( .D(N16), .CK(clk), .Q(cost[2]) );
  DFFQX1 \cost_reg[1]  ( .D(N15), .CK(clk), .Q(cost[1]) );
  DFFQX1 \cost_reg[0]  ( .D(N14), .CK(clk), .Q(cost[0]) );
  EDFFTRX1 \o_cost_reg[1]  ( .RN(n5), .D(cost[1]), .E(count9), .CK(clk), .Q(
        o_cost[1]) );
  EDFFTRX1 \o_cost_reg[2]  ( .RN(n5), .D(cost[2]), .E(count9), .CK(clk), .Q(
        o_cost[2]) );
  EDFFTRX1 \o_cost_reg[3]  ( .RN(n5), .D(cost[3]), .E(count9), .CK(clk), .Q(
        o_cost[3]) );
  EDFFTRX1 \o_cost_reg[4]  ( .RN(n5), .D(cost[4]), .E(count9), .CK(clk), .Q(
        o_cost[4]) );
  EDFFTRX1 \o_cost_reg[5]  ( .RN(n5), .D(cost[5]), .E(count9), .CK(clk), .Q(
        o_cost[5]) );
  EDFFTRX1 \o_cost_reg[6]  ( .RN(n5), .D(cost[6]), .E(count9), .CK(clk), .Q(
        o_cost[6]) );
  EDFFTRX1 \o_cost_reg[7]  ( .RN(n5), .D(cost[7]), .E(count9), .CK(clk), .Q(
        o_cost[7]) );
  EDFFTRX1 \o_cost_reg[8]  ( .RN(n5), .D(cost[8]), .E(count9), .CK(clk), .Q(
        o_cost[8]) );
  EDFFTRX1 \o_cost_reg[9]  ( .RN(n5), .D(cost[9]), .E(count9), .CK(clk), .Q(
        o_cost[9]) );
  EDFFTRX1 \o_cost_reg[10]  ( .RN(n5), .D(cost[10]), .E(count9), .CK(clk), .Q(
        o_cost[10]) );
  EDFFTRX1 \o_cost_reg[0]  ( .RN(n5), .D(cost[0]), .E(count9), .CK(clk), .Q(
        o_cost[0]) );
  AO22XL U3 ( .A0(i_cost[0]), .A1(N38), .B0(N3), .B1(n2), .Y(N14) );
  AO22X1 U4 ( .A0(i_cost[7]), .A1(N38), .B0(N10), .B1(n2), .Y(N21) );
  AO22X1 U6 ( .A0(i_cost[6]), .A1(N38), .B0(N9), .B1(n2), .Y(N20) );
  AO22X1 U7 ( .A0(i_cost[5]), .A1(N38), .B0(N8), .B1(n2), .Y(N19) );
  AO22X1 U8 ( .A0(i_cost[4]), .A1(N38), .B0(N7), .B1(n2), .Y(N18) );
  AO22X1 U9 ( .A0(i_cost[3]), .A1(N38), .B0(N6), .B1(n2), .Y(N17) );
  AO22X1 U10 ( .A0(i_cost[2]), .A1(N38), .B0(N5), .B1(n2), .Y(N16) );
  NOR2BX2 U11 ( .AN(count9), .B(rst), .Y(N38) );
  AO22X1 U12 ( .A0(i_cost[1]), .A1(N38), .B0(N4), .B1(n2), .Y(N15) );
  CLKBUFX3 U13 ( .A(n4), .Y(n2) );
  NOR2X1 U14 ( .A(count9), .B(rst), .Y(n4) );
  INVX3 U15 ( .A(rst), .Y(n5) );
  CLKBUFX3 U16 ( .A(n6), .Y(count9) );
endmodule


module control_DW01_inc_0_DW01_inc_1 ( A, SUM );
  input [18:0] A;
  output [18:0] SUM;

  wire   [18:2] carry;

  ADDHXL U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  ADDHXL U1_1_17 ( .A(A[17]), .B(carry[17]), .CO(carry[18]), .S(SUM[17]) );
  ADDHXL U1_1_12 ( .A(A[12]), .B(carry[12]), .CO(carry[13]), .S(SUM[12]) );
  ADDHXL U1_1_16 ( .A(A[16]), .B(carry[16]), .CO(carry[17]), .S(SUM[16]) );
  ADDHXL U1_1_15 ( .A(A[15]), .B(carry[15]), .CO(carry[16]), .S(SUM[15]) );
  ADDHXL U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  ADDHXL U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHXL U1_1_8 ( .A(A[8]), .B(carry[8]), .CO(carry[9]), .S(SUM[8]) );
  ADDHXL U1_1_10 ( .A(A[10]), .B(carry[10]), .CO(carry[11]), .S(SUM[10]) );
  ADDHXL U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ADDHXL U1_1_11 ( .A(A[11]), .B(carry[11]), .CO(carry[12]), .S(SUM[11]) );
  ADDHXL U1_1_13 ( .A(A[13]), .B(carry[13]), .CO(carry[14]), .S(SUM[13]) );
  ADDHXL U1_1_14 ( .A(A[14]), .B(carry[14]), .CO(carry[15]), .S(SUM[14]) );
  ADDHXL U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHXL U1_1_9 ( .A(A[9]), .B(carry[9]), .CO(carry[10]), .S(SUM[9]) );
  ADDHXL U1_1_7 ( .A(A[7]), .B(carry[7]), .CO(carry[8]), .S(SUM[7]) );
  ADDHXL U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  INVXL U1 ( .A(A[0]), .Y(SUM[0]) );
  XOR2X1 U2 ( .A(carry[18]), .B(A[18]), .Y(SUM[18]) );
endmodule


module control ( clk, rst, permute_valid, sum_valid, permute_out, sum_out, 
        out_valid, W, count8 );
  output [2:0] W;
  input clk, rst, permute_valid, sum_valid;
  output permute_out, sum_out, out_valid, count8;
  wire   n28, n29, N11, N12, N13, N14, N15, N16, N17, N18, N19, N20, N21, N22,
         N23, N24, N25, N26, N27, N28, N29, N91, n5, n6, n7, n8, n9, n10, n11,
         n12, n13, n14, n15, n16, n1, n3, n4, n17, n19, n21, n22, n24, n25,
         n26, n27;
  wire   [18:3] count;
  wire   [1:0] state;
  assign count8 = N91;

  control_DW01_inc_0_DW01_inc_1 add_51 ( .A({count, W[2], n28, W[0]}), .SUM({
        N29, N28, N27, N26, N25, N24, N23, N22, N21, N20, N19, N18, N17, N16, 
        N15, N14, N13, N12, N11}) );
  DFFQX1 \state_reg[0]  ( .D(n25), .CK(clk), .Q(state[0]) );
  EDFFTRX1 \count_reg[16]  ( .RN(n27), .D(N27), .E(n21), .CK(clk), .Q(
        count[16]) );
  EDFFTRX1 \count_reg[17]  ( .RN(n27), .D(N28), .E(n21), .CK(clk), .Q(
        count[17]) );
  EDFFTRX1 \count_reg[6]  ( .RN(n27), .D(N17), .E(sum_out), .CK(clk), .Q(
        count[6]) );
  EDFFTRX1 \count_reg[8]  ( .RN(n27), .D(N19), .E(sum_out), .CK(clk), .Q(
        count[8]) );
  EDFFTRX1 \count_reg[18]  ( .RN(n27), .D(N29), .E(sum_out), .CK(clk), .Q(
        count[18]) );
  EDFFTRX1 \count_reg[10]  ( .RN(n27), .D(N21), .E(sum_out), .CK(clk), .Q(
        count[10]) );
  EDFFTRX1 \count_reg[11]  ( .RN(n27), .D(N22), .E(sum_out), .CK(clk), .Q(
        count[11]) );
  EDFFTRX1 \count_reg[3]  ( .RN(n27), .D(N14), .E(sum_out), .CK(clk), .Q(
        count[3]) );
  EDFFTRX1 \count_reg[4]  ( .RN(n27), .D(N15), .E(sum_out), .CK(clk), .Q(
        count[4]) );
  EDFFTRX1 \count_reg[5]  ( .RN(n27), .D(N16), .E(sum_out), .CK(clk), .Q(
        count[5]) );
  EDFFTRX1 \count_reg[9]  ( .RN(n27), .D(N20), .E(sum_out), .CK(clk), .Q(
        count[9]) );
  EDFFTRX1 \count_reg[7]  ( .RN(n27), .D(N18), .E(sum_out), .CK(clk), .Q(
        count[7]) );
  EDFFTRX1 \count_reg[14]  ( .RN(n27), .D(N25), .E(sum_out), .CK(clk), .Q(
        count[14]) );
  EDFFTRX1 \count_reg[13]  ( .RN(n27), .D(N24), .E(sum_out), .CK(clk), .Q(
        count[13]) );
  EDFFTRX1 \count_reg[15]  ( .RN(n27), .D(N26), .E(sum_out), .CK(clk), .Q(
        count[15]) );
  EDFFTRX1 \count_reg[12]  ( .RN(n27), .D(N23), .E(sum_out), .CK(clk), .Q(
        count[12]) );
  DFFQX1 \state_reg[1]  ( .D(n24), .CK(clk), .Q(state[1]) );
  EDFFTRX1 \count_reg[1]  ( .RN(n27), .D(N12), .E(n21), .CK(clk), .Q(n28), 
        .QN(n17) );
  MXI2X1 \count_reg[0]/U4  ( .A(n29), .B(N11), .S0(sum_out), .Y(n3) );
  NOR2BX1 \count_reg[0]/U2  ( .AN(n27), .B(n3), .Y(n4) );
  DFFQX1 \count_reg[0]  ( .D(n4), .CK(clk), .Q(n29) );
  EDFFTRX1 \count_reg[2]  ( .RN(n27), .D(N13), .E(n21), .CK(clk), .QN(n1) );
  INVX16 U3 ( .A(n1), .Y(W[2]) );
  INVX3 U4 ( .A(rst), .Y(n27) );
  CLKINVX1 U5 ( .A(n29), .Y(n19) );
  INVX16 U6 ( .A(n17), .Y(W[1]) );
  INVX16 U7 ( .A(n19), .Y(W[0]) );
  CLKINVX1 U8 ( .A(n9), .Y(n26) );
  NAND4X1 U9 ( .A(count[6]), .B(count[8]), .C(count[10]), .D(count[11]), .Y(
        n13) );
  NAND4BBXL U10 ( .AN(count[16]), .BN(count[17]), .C(n15), .D(n16), .Y(n12) );
  NAND4X1 U11 ( .A(N91), .B(count[3]), .C(count[4]), .D(count[5]), .Y(n14) );
  NOR4BBX1 U12 ( .AN(count[15]), .BN(count[12]), .C(count[14]), .D(count[13]), 
        .Y(n16) );
  NOR3X1 U13 ( .A(count[18]), .B(count[9]), .C(count[7]), .Y(n15) );
  NAND2X1 U14 ( .A(n11), .B(n5), .Y(n9) );
  AOI22X1 U15 ( .A0(sum_valid), .A1(n8), .B0(permute_valid), .B1(permute_out), 
        .Y(n11) );
  NOR2X1 U16 ( .A(rst), .B(n6), .Y(n5) );
  AND2X2 U17 ( .A(sum_out), .B(n27), .Y(n6) );
  CLKINVX1 U18 ( .A(n7), .Y(n24) );
  AOI32X1 U19 ( .A0(n8), .A1(n27), .A2(n9), .B0(state[1]), .B1(n26), .Y(n7) );
  CLKINVX1 U20 ( .A(n10), .Y(n25) );
  AOI32X1 U21 ( .A0(permute_out), .A1(n27), .A2(n9), .B0(n26), .B1(state[0]), 
        .Y(n10) );
  INVX3 U22 ( .A(n22), .Y(sum_out) );
  CLKINVX1 U23 ( .A(n21), .Y(n22) );
  NOR2BX1 U24 ( .AN(state[1]), .B(state[0]), .Y(n21) );
  NOR2X1 U25 ( .A(state[0]), .B(state[1]), .Y(permute_out) );
  NOR2X1 U26 ( .A(permute_out), .B(state[1]), .Y(n8) );
  AND3XL U27 ( .A(n28), .B(W[2]), .C(W[0]), .Y(N91) );
  NOR3X1 U28 ( .A(n12), .B(n13), .C(n14), .Y(out_valid) );
endmodule


module JAM ( CLK, RST, W, J, Cost, MatchCount, MinCost, Valid );
  output [2:0] W;
  output [2:0] J;
  input [7:0] Cost;
  output [3:0] MatchCount;
  output [9:0] MinCost;
  input CLK, RST;
  output Valid;
  wire   n8, n9, n10, n11, sum_out, count8, sumFinish, n2, n4, n6;
  wire   [10:0] totalCost;

  permute permute ( .W(W), .clk(CLK), .rst(RST), .finish(sum_out), .J({n8, n9, 
        n10}) );
  accumulator accumulator ( .clk(CLK), .rst(RST), .count8(count8), .i_cost(
        Cost), .i_count(W), .o_cost(totalCost), .finish(sumFinish) );
  control control ( .clk(CLK), .rst(RST), .permute_valid(1'b0), .sum_valid(
        sumFinish), .sum_out(sum_out), .out_valid(n11), .W(W), .count8(count8)
         );
  result result ( .clk(sumFinish), .rst(RST), .sumFinish(sumFinish), .i_sum(
        totalCost), .matchCount(MatchCount), .minCost(MinCost) );
  CLKINVX1 U1 ( .A(n10), .Y(n4) );
  CLKINVX1 U2 ( .A(n9), .Y(n6) );
  INVX12 U3 ( .A(n4), .Y(J[0]) );
  INVX12 U4 ( .A(n6), .Y(J[1]) );
  INVX12 U5 ( .A(n2), .Y(J[2]) );
  CLKINVX1 U6 ( .A(n8), .Y(n2) );
  BUFX12 U7 ( .A(n11), .Y(Valid) );
endmodule

