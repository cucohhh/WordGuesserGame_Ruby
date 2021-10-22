class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    # @guesses = ''
    # @wrong_guesses=''
    @correct_guesses_list =''
    @wrong_guesses_list =""
    
  end


  # setter 
  def word=(value)
    return @word=value
  end


  # getter
  def word
    return @word
  end
  
  



  # 定义guesses 方法
  def guesses
     

    return @correct_guesses_list

  end

 


  #定义wrong_guesses 
  def wrong_guesses
    
    return @wrong_guesses_list
  end

  

  #guess 判断word中是否有guess字符 若有则更新guesses 否则更新wrong_guesses
  def guess(value)
    
    if value=='' || value=='%' || value==nil
      raise ArgumentError
    
    else
      value = value.downcase
      mystr = String(word)
      puts word
      word_include_result = mystr.include? value
  
      # 存入数组是需要先判断list中是否包含即将存入的字符
      # 不包含则存入 返回 true
      # 包含则不存入 返回 flase

      insert_flag = false
      if word_include_result == true
        correct_list_include = @correct_guesses_list.include? value
        if !correct_list_include
          @correct_guesses_list << value
          insert_flag = true
        end
     
     
      
      
      else
        wrong_list_include =@wrong_guesses_list.include? value
        if !wrong_list_include
          @wrong_guesses_list << value
          insert_flag = true
        end
      
      
      end
    end
    
    
    
    return insert_flag
  end


  def guess_several_letters(value)
    for i in 0...(value.length)
      
      guess(value[i].downcase)
    end
    return
  end

  def word_with_guesses
    #遍历 word
    #若字符在正确猜词列表中存在则显示，否则显示'-'
    @guesses_display = ''
    for i in 0...(@word.length)
      include_flag = @correct_guesses_list.include? word[i]
      if include_flag
        @guesses_display << @word[i]
      else
        @guesses_display << '-'
      end
    end

    return @guesses_display
  end

  def check_win_or_lose
    if @wrong_guesses_list.length >=6
      return :lose

    
      
    elsif @correct_guesses_list.length == @word.length
      
      return :win
    else
      return :play
      
    
    end 

  end


 

  

  

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
