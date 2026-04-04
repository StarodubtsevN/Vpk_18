module laba1_testbench();
  logic [3:0] d0, d1, d2, d3;
  logic [1:0] s;
  logic [3:0] sel;
  logic [8:0] dout;
  
  laba1_mux_f_demux dut (.*);
  
  function logic expected_y(logic x1, x2, x3, x4);
    return (x1 & x2) | (x2 & x3) | (~x3 & ~x4) | (x1 & ~x4);
  endfunction
  
  initial begin
    integer x, ch, addr;
    logic x1, x2, x3, x4;
    logic expected;
    integer error_cnt = 0;
    
    // Перебираем все 4 канала мультиплексора (s = 0,1,2,3)
    for (ch = 0; ch < 4; ch++) begin
      // Для каждого канала перебираем все 16 комбинаций x1..x4
      for (x = 0; x < 16; x++) begin
        x1 = (x >> 0) & 1;
        x2 = (x >> 1) & 1;
        x3 = (x >> 2) & 1;
        x4 = (x >> 3) & 1;
        
        // Подаём комбинацию на соответствующий канал
        d0 = (ch == 0) ? {x1, x2, x3, x4} : 4'b0;
        d1 = (ch == 1) ? {x1, x2, x3, x4} : 4'b0;
        d2 = (ch == 2) ? {x1, x2, x3, x4} : 4'b0;
        d3 = (ch == 3) ? {x1, x2, x3, x4} : 4'b0;
        s = ch;
        
        // Перебираем адреса демультиплексора
        for (addr = 0; addr < 9; addr++) begin
          sel = addr;
          #10;
          expected = expected_y(x1, x2, x3, x4);
          if (dout[addr] !== expected) begin
            $error("Ошибка: ch=%0d x=(%b,%b,%b,%b) sel=%0d", ch, x1, x2, x3, x4, addr);
            error_cnt++;
          end
          for (int i = 0; i < 9; i++)
            if (i != addr && dout[i] !== 0) error_cnt++;
        end
      end
    end
    
    if (error_cnt == 0)
      $display("Тест успешен: 4 канала × 16 комбинаций × 9 адресов = 576 проверок.");
    else
      $display("Ошибок: %0d", error_cnt);
    $finish;
  end
endmodule