module SudokuGame
    using Random

    export sudoku_gen
    export determin
    export reset!

    include(joinpath(@__DIR__, "types.jl"))

    @views function sudoku_gen(; mode=:easy)
        s_1 = [4 2 8 5 3 9 6 7 1; 1 7 5 4 6 8 2 3 9; 6 3 9 7 1 2 5 4 8
            3 5 2 8 4 1 7 9 6; 8 6 4 2 9 7 1 5 3; 7 9 1 6 5 3 8 2 4
            2 1 6 3 7 4 9 8 5; 5 4 7 9 8 6 3 1 2; 9 8 3 1 2 5 4 6 7]
        s_2 = [5 3 4 8 7 1 9 2 6; 6 8 9 2 3 4 7 1 5; 1 2 7 9 5 6 4 3 8
            4 5 8 7 6 2 3 9 1; 3 1 6 4 9 8 5 7 2; 9 7 2 3 1 5 6 8 4
            7 4 1 5 2 3 8 6 9; 8 6 3 1 4 9 2 5 7; 2 9 5 6 8 7 1 4 3]
        s_3 = [9 5 6 3 7 8 1 4 2; 4 1 8 9 6 2 3 5 7; 7 3 2 5 4 1 9 8 6
            3 4 7 1 2 5 6 9 8; 8 2 1 7 9 6 4 3 5; 5 6 9 8 3 4 7 2 1
            1 9 3 2 8 7 5 6 4; 2 7 4 6 5 9 8 1 3; 6 8 5 4 1 3 2 7 9]
        sudoku_seed = [s_1, s_2, s_3]
        sudoku_choo = rand(sudoku_seed, 1)[1]
        pos = shuffle(1:1:9)
        new_sudoku = zeros(Int, 9, 9)
        @inbounds for j in 1:9, i in eachindex(sudoku_choo)
            sudoku_choo[i]==j ? new_sudoku[i] = pos[j] : nothing
        end
        raw = copy(new_sudoku)
        if mode==:normal
            blank_num = trunc(Int, 81*(1-rand(0.14:0.01:0.26, 1)[1]))
            blank_pos = rand(1:81, blank_num)
            raw[blank_pos] .= 0
        elseif mode==:hard
            blank_num = trunc(Int, 81*(1-rand(0.06:0.01:0.13, 1)[1]))
            blank_pos = rand(1:81, blank_num)
            raw[blank_pos] .= 0
        else
            blank_num = trunc(Int, 81*(1-rand(0.27:0.01:0.40, 1)[1]))
            blank_pos = rand(1:81, blank_num)
            raw[blank_pos] .= 0
        end
        return Sudoku(raw=raw, answer=new_sudoku, mode=mode)
    end

    function determin(sudo::Sudoku)
        que = sudo.solve
        ans = collect(Int32, 1:1:9)
        sta = true
        @inbounds for i in 1:9
            sort(unique(que[i, :]))==ans ? nothing : (
                println("❌ Error in Row $(i)"); sta=false)
            sort(unique(que[:, i]))==ans ? nothing : (
                println("❌ Error in Col $(i)"); sta=false)
        end
        @inbounds for i in 1:3, j in 1:3
            sort(unique(que[i*3-2:i*3, j*3-2:j*3]))==ans ? nothing : (
                println("❌ Error in block C$(i*3-2)$(i*3)R$(j*3-2)$(j*3)"); sta=false
            )
        end
        sta==true ? (println("✅ Congratulation")) : nothing
        return nothing
    end

    function reset!(sudo::Sudoku)
        sudo.solve .= sudo.raw
        return nothing
    end
end
