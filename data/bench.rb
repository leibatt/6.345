require 'benchmark'

def generate_syllables count
  words = []
  (count / 2).times { words << "about" }
  words << "the" if count % 2 == 1
  words.join(" ")
end

Benchmark.bmbm do |x|
  (1..15).each do |num_syllables|
    prefix = "bench/bench-#{num_syllables}"
    x.report("#{num_syllables} 1") { `fst from_string #{prefix}-1.fst #{generate_syllables num_syllables}` }
    x.report("#{num_syllables} 2") { `fst compose -t - fst/pocket_bcf-inverted-closure.fst #{prefix}-2.fst < #{prefix}-1.fst` }
    x.report("#{num_syllables} 3") { `fst compose -t - fst/phoneme_to_stress.fst #{prefix}-3.fst < #{prefix}-2.fst` }
    x.report("#{num_syllables} 4") { `fst compose -t - fst/stress_to_phoneme.fst #{prefix}-4.fst < #{prefix}-3.fst` }
    x.report("#{num_syllables} 5") { `fst compose -t - fst/pocket_bcf-closure.fst #{prefix}-5.fst < #{prefix}-4.fst` }
    x.report("#{num_syllables} 6") { `fst clear_weights - #{prefix}-6.fst < #{prefix}-5.fst` }
    x.report("#{num_syllables} 7") { `fst compose -t - fst/lyrics-ngram.fst #{prefix}-7.fst < #{prefix}-6.fst` }
    x.report("#{num_syllables} 8") { `fst nbest -s -o -n 30 - #{prefix}-8.txt < #{prefix}-7.fst` }
  end
end


# fst from_string - i gonna be a mighty king |
# fst compose -t - pocket_bcf-inverted-closure.fst - |
# fst compose -t - phoneme_to_stress.fst - |
# fst compose -t - stress_to_phoneme.fst - |
# fst compose -t - pocket_bcf-closure.fst - |
# fst clear_weights - - |
# fst compose -t - lyrics-ngram.fst - |
# fst nbest -s -o -n 10 - -
