module Compare (
    input  equal_i       ,
    input  func3_0_i     ,
    input  branch_i      ,
    output branch_taken_o
);

    assign branch_taken_o = branch_i & (equal_i ^ func3_0_i);

endmodule