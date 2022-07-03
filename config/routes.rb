Rails.application.routes.draw do

  #-------------------------------------------------
  # app namespace
  #-------------------------------------------------

  constraints format: 'html' do

    # named routes (statics)
    get 'day01' => 'statics#day01', as: :day01
    get 'day02' => 'statics#day02', as: :day02
    get 'day03' => 'statics#day03', as: :day03
    get 'day04' => 'statics#day04', as: :day04
    get 'day05' => 'statics#day05', as: :day05
    get 'day06' => 'statics#day06', as: :day06
    get 'day07' => 'statics#day07', as: :day07
    get 'day08' => 'statics#day08', as: :day08
    get 'day09' => 'statics#day09', as: :day09
    get 'day10' => 'statics#day10', as: :day10
    get 'day11' => 'statics#day11', as: :day11
    get 'day12' => 'statics#day12', as: :day12
    get 'day13' => 'statics#day13', as: :day13
    get 'day14' => 'statics#day14', as: :day14
    get 'day15' => 'statics#day15', as: :day15
    get 'day16' => 'statics#day16', as: :day16
    get 'day17' => 'statics#day17', as: :day17
    get 'day18' => 'statics#day18', as: :day18
    get 'day19' => 'statics#day19', as: :day19
    get 'day20' => 'statics#day20', as: :day20
    get 'day21' => 'statics#day21', as: :day21
    get 'day22' => 'statics#day22', as: :day22
    get 'day23' => 'statics#day23', as: :day23
    get 'day24' => 'statics#day24', as: :day24
    get 'day25' => 'statics#day25', as: :day25
    get 'day25answer' => 'statics#day25answer', as: :day25answer

  end

  # default route
  root to: 'statics#index'

end
