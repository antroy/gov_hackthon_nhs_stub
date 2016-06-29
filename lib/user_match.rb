module UserMatch
    def match(surname, dob, users)
        surname.upcase!
        out = Hash[
            users.find_all do |k, v|
                data = v['data']
                exp_surname = data && data['surname'][0..2].upcase
                exp_dob = data && data['dob']

                surname_match = surname.start_with?(exp_surname)
                dob_match = dob == exp_dob

                surname_match && dob_match
            end
        ]

        out
    end
    module_function :match
end
