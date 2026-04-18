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
    
    // Начальная инициализация всех входов для избежания X
    d0 = 4'b0; d1 = 4'b0; d2 = 4'b0; d3 = 4'b0;
    s = 2'b0; sel = 4'b0;
    #10;
    
    // Перебираем все 4 канала мультиплексора (s = 0,1,2,3)
    for (ch = 0; ch < 4; ch++) begin
      // Для каждого канала перебираем все 16 комбинаций x1..x4
      for (x = 0; x < 16; x++) begin
        x1 = (x >> 0) & 1;
        x2 = (x >> 1) & 1;
        x3 = (x >> 2) & 1;
        x4 = (x >> 3) & 1;
        
        // Подаём комбинацию на соответствующий канал
        // В модуле laba1 входы x1..x4 соответствуют битам mux_out[0]..mux_out[3]
        // Поэтому младший бит шины данных должен быть x1, старший - x4
        d0 = (ch == 0) ? {x4, x3, x2, x1} : 4'b0;
        d1 = (ch == 1) ? {x4, x3, x2, x1} : 4'b0;
        d2 = (ch == 2) ? {x4, x3, x2, x1} : 4'b0;
        d3 = (ch == 3) ? {x4, x3, x2, x1} : 4'b0;
        s = ch;
        
        // Перебираем адреса демультиплексора
        for (addr = 0; addr < 9; addr++) begin
          sel = addr;  // addr от 0 до 8, sel[3:0] будет 0000..1000
          #10;
          expected = expected_y(x1, x2, x3, x4);
          
          // Проверяем активный выход
          if (dout[addr] !== expected) begin
            $error("ERROR: ch=%0d x=(%b,%b,%b,%b) sel=%0d: dout[%0d]=%b, expected=%b", 
                   ch, x1, x2, x3, x4, addr, addr, dout[addr], expected);
            error_cnt++;
          end
          
          // Проверяем все неактивные выходы (должны быть 0)
          for (int i = 0; i < 9; i++) begin
            if (i != addr && dout[i] !== 0) begin
              $error("ERROR: ch=%0d x=(%b,%b,%b,%b) sel=%0d: non-selected dout[%0d]=%b (should be 0)", 
                     ch, x1, x2, x3, x4, addr, i, dout[i]);
              error_cnt++;
            end
          end
        end
      end
    end
    
    if (error_cnt == 0)
      $display("Test completed: 4 × 16 × 9 addresses = 576 tests. No errors.");
    else
      $display("Test completed with %0d errors.", error_cnt);
    $finish;
  end
endmodule