shared 'Proc#to_source from { ... } block (w nested hash (w label-key))' do

  should 'handle simple' do
    (
      lambda {
        {a: 1, b: 2}
      }
    ).should.be having_code(%Q\
      proc do
        {:a => 1, :b => 2}
      end
    \)
  end

  should 'handle nested' do
    (
      lambda {
        {a: 1, b: {c: 3}}
      }
    ).should.be having_code(%Q\
      proc do
        {:a => 1, :b => {:c => 3}}
      end
    \)
  end

end
