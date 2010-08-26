shared 'Proc#to_source from { ... } block (1.9.*)' do

  should 'handle simple (w label keys)' do
    (
      lambda {
        {a: 1, b: 2}
      }
    ).should.be having_source(%Q\
      proc do
        {:a => 1, :b => 2}
      end
    \)
  end

  should 'handle nested (w label keys)' do
    (
      lambda {
        {a: 1, b: {c: 3}}
      }
    ).should.be having_source(%Q\
      proc do
        {:a => 1, :b => {:c => 3}}
      end
    \)
  end

end
