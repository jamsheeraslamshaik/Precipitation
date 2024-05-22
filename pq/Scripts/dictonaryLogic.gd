extends Node

var correct_dict = {
	"KCl":"Hg2(NO3)2", #problem 1
	"Na2C2O4":"CaCl2", #problem 2
	"KF":"MgSO4", #problem 3
	"AlCl3":"NaOH", #problem 4
	"Na2CO3":"CaO", #5
	"(NO2)2Pb":"Na3PO4", #6
	"Br2Ca":"K2CO3", #7
	#"KNO3":"help", #8 - no solution
	"FeCl":"NaOH", #9
	"Na3PO4":"CaCl2", #10
	"K3AsO4":"FeCl2", #11
	"CdSO4":"Na2S", #12
	"CrSCN3":"NaOH", #13
	#"LiClO4":"help", #14 - no solution
	"NO3Ag":"NaCl", #15
	"K2CrO4":"BaCl2", #16
	"Na4PO4OH":"Ca(NO3)2", #17 ?
	"Na4(AsO4)OH":"CuCl2", #18 ?
	"Cl2Hg(II)O6":"K2S", #19
	"Hg(I)(NO3)2":"Na2CO3", #20
	# New questions start here
	"AgNO3":"NaCl", #21
	"CuSO4":"NaOH", #22
	"Pb(NO3)2":"KI", #23
	"BaCl2":"H2SO4", #24
	"ZnSO4":"Na2CO3", #25
	"FeSO4":"NaOH", #26
	"HgCl2":"KI", #27
	"Ca(NO3)2":"Na2CO3", #28
	"MgCl2":"NaOH", #29
	"Al(NO3)3":"NaOH", #30
	"NiCl2":"NaOH", #31
	"CoCl2":"NaOH", #32
	"SrCl2":"Na2SO4", #33
	"CdCl2":"Na2S", #34
	"MnCl2":"NaOH", #35
	"Cr(NO3)3":"NaOH", #36
	"Li2CO3":"HCl", #37
	"NaHCO3":"HCl", #38
	"K2SO4":"BaCl2", #39
	"NH4Cl":"NaOH" #40
}

var problem_dict = {
	"KCl":["Hg2(NO3)2", "AgBr", "MgCO3"], #problem 1
	"Na2C2O4":["CaCl2", "CaSO4","KCl"], #problem 2
	"KF":["MgSO4", "CuS","Ca3(PO4)2"], #problem 3
	"AlCl3":["NaOH", "Ba3(PO4)3", "KClO3"], #problem 4
	"Na2CO3":["CaO", "NH4I", "Fe(OH)3"], #5
	"(NO2)2Pb":["Na3PO4", "ZnClO4", "NiS"], #6
	"Br2Ca":["K2CO3", "MgCl2", "NH4C2H3O2"], #7
	#"KNO3":["FeCl3", "Al2(SO4)3", "Ag2CO3"], #8 - no solution
	"FeCl":["NaOH", "KSCN", "LiC2H3O2"], #9
	"Na3PO4":["CaCl2", "NH4F", "KI"], #10
	"K3AsO4":["FeCl2","NaBr", "KF"], #11
	"CdSO4":["Na2S", "NaC2H3O2", "K2SO4"], #12
	"CrSCN3":["NaOH", "KClO4", "Na2SO4"], #13
	#"LiClO4":["CuO", "AlBr3", "Ca(OH)2"], #14 - no solution
	"NO3Ag":["NaCl", "KF", "Ca(ClO4)2"], #15
	"K2CrO4":["BaCl2", "KCl", "LiBr"], #16
	"Na4PO4OH":["Ca(NO3)2", "NaOH", "KBr"], #17 ?
	"Na4(AsO4)OH":["CuCl2", "KC2H3O2", "NaI"], #18 ?
	"Cl2Hg(II)O6":["K2S", "KBr", "NaCl"], #19
	"Hg(I)(NO3)2":["Na2CO3", "KClO4", "LiNO3"], #20
	# New questions start here
	"AgNO3":["NaCl", "KBr", "LiI"], #21
	"CuSO4":["NaOH", "KCl", "NH4NO3"], #22
	"Pb(NO3)2":["KI", "NaCl", "K2SO4"], #23
	"BaCl2":["H2SO4", "Na2CO3", "CaSO4"], #24
	"ZnSO4":["Na2CO3", "KCl", "LiNO3"], #25
	"FeSO4":["NaOH", "KCl", "NH4NO3"], #26
	"HgCl2":["KI", "NaBr", "K2SO4"], #27
	"Ca(NO3)2":["Na2CO3", "KCl", "LiNO3"], #28
	"MgCl2":["NaOH", "KCl", "NH4NO3"], #29
	"Al(NO3)3":["NaOH", "K2SO4", "NaCl"], #30
	"NiCl2":["NaOH", "KCl", "NH4NO3"], #31
	"CoCl2":["NaOH", "KBr", "LiNO3"], #32
	"SrCl2":["Na2SO4", "KCl", "NH4NO3"], #33
	"CdCl2":["Na2S", "KCl", "NH4NO3"], #34
	"MnCl2":["NaOH", "KCl", "LiNO3"], #35
	"Cr(NO3)3":["NaOH", "K2SO4", "NaCl"], #36
	"Li2CO3":["HCl", "KBr", "NaOH"], #37
	"NaHCO3":["HCl", "KCl", "LiNO3"], #38
	"K2SO4":["BaCl2", "Na2CO3", "NH4NO3"], #39
	"NH4Cl":["NaOH", "KCl", "LiNO3"] #40
}

var problem_options = correct_dict.keys()
#create a update_phial script to wipe old phials and replace with new text
#Call this anytime the player clicks on the phial
func flask_throw(puddle_key, phial_compound):
	if phial_compound == correct_dict[puddle_key]:
		get_parent().correct()
		print("correct")
		#update buttons and puddle
	else:
		get_parent().incorrect()
		print("incorrect")

func startGameText():
	var randomIndex = randi() % problem_options.size()
	var randomKey = problem_options[randomIndex]
	problem_options.remove_at(randomIndex)
	var randomList = problem_dict[randomKey]
	randomList.shuffle()
	get_parent().puddle = randomKey
	get_parent().button_options = randomList
	get_parent().call("updateText")
