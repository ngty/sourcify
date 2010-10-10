require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

unless has_parsetree?
describe "Heredoc (wo indent)" do
  %w{X "X" 'X'}.each do |tag|

    should "handle <<#{tag}\\n .. \\nX\\n" do
      process(%Q(
            s <<#{tag}
 aa 
X
             )).should.include([:heredoc, "<<#{tag}\n aa \nX"])
    end

    should "not handle <<#{tag} \\n .. \\nX\\n" do
      process(%Q(
            s << #{tag}
 aa 
X
             )).should.not.include([:heredoc, "<<#{tag} \n aa \nX"])
    end

    should "not handle <<#{tag}\\n .. \\n X\\n" do
      process(%Q(
            s <<#{tag}
 aa 
 X
             )).should.not.include([:heredoc, "<<#{tag} \n aa \n X"])
    end

    should "not handle <<#{tag}\\n .. \\nX \\n" do
      process(%Q(
            s <<#{tag}
 aa
X 
             )).should.not.include([:heredoc, "<<#{tag} \n aa \nX "])
    end

    should "not handle class <<#{tag}\\n .. \\nX \\n" do
      process(%Q(

            class <<#{tag}
 aa 
X
             )).should.not.include([:heredoc, "<<#{tag}\n aa \nX"])
    end

    should "handle xclass <<#{tag}\\n .. \\nX \\n" do
      process(%Q(
            xclass <<#{tag}
 aa 
X
             )).should.include([:heredoc, "<<#{tag}\n aa \nX"])
    end

    should "handle classx <<#{tag}\\n .. \\nX \\n" do
      process(%Q(
            classx <<#{tag}
 aa 
X
             )).should.include([:heredoc, "<<#{tag}\n aa \nX"])
    end

    should "handle <<#{tag}\\n .. \\nX \\n" do
      process(%Q(
<<#{tag}
 aa 
X
             )).should.include([:heredoc, "<<#{tag}\n aa \nX"])
    end

  end
end

describe "Heredoc (w indent)" do
  %w{X "X" 'X'}.each do |tag|

    should "handle <<-#{tag}\\n .. \\nX\\n" do
      process(%Q(
            s <<-#{tag}
 aa 
X
             )).should.include([:heredoc, "<<-#{tag}\n aa \nX"])
    end

    should "handle <<-#{tag}\\n .. \\n X\\n" do
      process(%Q(
            s <<-#{tag}
 aa 
 X
             )).should.include([:heredoc, "<<-#{tag}\n aa \n X"])
    end

    should "not handle <<-#{tag} \\n .. \\nX\\n" do
      process(%Q(
            s <<-#{tag} 
 aa 
X
             )).should.not.include([:heredoc, "<<-#{tag} \n aa \n X"])
    end

    should "not handle <<-#{tag}\\n .. \\nX \\n" do
      process(%Q(
            s <<-#{tag}
 aa 
X 
             )).should.not.include([:heredoc, "<<-#{tag}\n aa \nX "])
    end

    should "not handle class <<-#{tag}\\n .. \\nX \\n" do
      process(%Q(
            class <<-#{tag}
 aa 
X
             )).should.not.include([:heredoc, "<<-#{tag}\n aa \nX"])
    end

    should "handle xclass <<-#{tag}\\n .. \\nX \\n" do
      process(%Q(
            xclass <<-#{tag}
 aa 
X
             )).should.include([:heredoc, "<<-#{tag}\n aa \nX"])
    end

    should "handle classx <<-#{tag}\\n .. \\nX \\n" do
      process(%Q(
            classx <<-#{tag}
 aa 
X
             )).should.include([:heredoc, "<<-#{tag}\n aa \nX"])
    end

    should "handle <<-#{tag}\\n .. \\nX \\n" do
      process(%Q(
<<-#{tag}
 aa 
X
             )).should.include([:heredoc, "<<-#{tag}\n aa \nX"])
    end

  end
end
end
