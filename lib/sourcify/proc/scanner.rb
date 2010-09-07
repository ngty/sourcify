
# line 1 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
require 'sourcify/proc/scanner/extensions'

module Sourcify
  module Proc
    module Scanner #:nodoc:all


# line 276 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"


# line 2 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rb"
class << self
	attr_accessor :_proc_scanner_actions
	private :_proc_scanner_actions, :_proc_scanner_actions=
end
self._proc_scanner_actions = [
	0, 1, 0, 1, 2, 1, 3, 1, 
	4, 1, 5, 1, 6, 1, 7, 1, 
	8, 1, 9, 1, 10, 1, 11, 1, 
	13, 1, 15, 1, 16, 1, 17, 1, 
	18, 1, 26, 1, 27, 1, 28, 1, 
	29, 1, 30, 1, 31, 1, 32, 1, 
	33, 1, 34, 1, 35, 1, 36, 1, 
	37, 1, 38, 1, 39, 1, 40, 1, 
	41, 1, 42, 1, 43, 1, 44, 1, 
	45, 1, 46, 1, 47, 1, 48, 1, 
	49, 2, 0, 1, 2, 3, 12, 2, 
	3, 14, 2, 3, 19, 2, 3, 20, 
	2, 3, 21, 2, 3, 22, 2, 3, 
	23, 2, 3, 24, 2, 3, 25
]

class << self
	attr_accessor :_proc_scanner_key_offsets
	private :_proc_scanner_key_offsets, :_proc_scanner_key_offsets=
end
self._proc_scanner_key_offsets = [
	0, 0, 1, 2, 3, 4, 5, 6, 
	9, 13, 16, 19, 23, 26, 28, 30, 
	33, 37, 40, 43, 47, 50, 53, 57, 
	60, 63, 67, 70, 73, 77, 80, 83, 
	87, 90, 93, 97, 100, 103, 107, 110, 
	113, 117, 120, 123, 127, 130, 133, 137, 
	140, 143, 147, 150, 153, 157, 160, 163, 
	167, 170, 173, 177, 180, 183, 187, 190, 
	193, 197, 200, 228, 231, 235, 238, 240, 
	243, 246, 250, 253, 256, 260, 263, 266, 
	270, 273, 276, 280, 283, 286, 290, 293, 
	296, 300, 303, 331, 333, 335, 337, 339, 
	341, 343, 345, 347, 349, 351, 353, 355, 
	357, 359, 361, 363, 365, 367, 369, 371, 
	373, 375, 377, 379, 381, 383, 385, 387, 
	389, 391, 393, 395, 397, 399, 401, 403, 
	405, 407, 409, 411, 413, 415, 417, 418, 
	420, 422, 423, 424, 426, 428, 430, 432, 
	434, 436, 438, 440, 442, 444, 446, 448, 
	456, 461, 471, 472, 479, 480, 481, 482, 
	483, 484, 485, 486, 487, 489, 490, 491, 
	492, 493, 494, 495, 496, 498, 499, 500, 
	501, 502, 503, 504, 505, 506, 507, 509, 
	511, 513, 515, 516, 517, 529, 551, 552, 
	553, 556, 590, 593, 594, 597, 600, 603, 
	606, 609, 612, 615, 618, 621, 624, 627, 
	630, 633, 636, 639, 642, 645, 648, 651, 
	652, 655, 658, 661, 664, 667, 670, 672, 
	674, 676, 678, 680, 682, 684, 686, 688, 
	690, 692, 694, 696, 698, 700, 702, 704, 
	706, 708, 710, 712, 714, 715, 717, 719, 
	721, 723, 725, 727, 732, 739, 740, 741, 
	749, 757, 766, 775, 784, 793, 802, 811, 
	820, 821, 822, 824, 826, 827, 828, 829, 
	830, 831, 832, 833, 834, 835, 836, 837, 
	838, 839
]

class << self
	attr_accessor :_proc_scanner_trans_keys
	private :_proc_scanner_trans_keys, :_proc_scanner_trans_keys=
end
self._proc_scanner_trans_keys = [
	98, 101, 103, 105, 110, 10, 34, 35, 
	92, 34, 35, 92, 123, 34, 35, 92, 
	33, 35, 92, 33, 35, 92, 123, 33, 
	35, 92, 35, 92, 35, 92, 35, 36, 
	92, 35, 36, 92, 123, 35, 36, 92, 
	35, 37, 92, 35, 37, 92, 123, 35, 
	37, 92, 35, 38, 92, 35, 38, 92, 
	123, 35, 38, 92, 35, 39, 92, 35, 
	39, 92, 123, 35, 39, 92, 35, 41, 
	92, 35, 41, 92, 123, 35, 41, 92, 
	35, 42, 92, 35, 42, 92, 123, 35, 
	42, 92, 35, 43, 92, 35, 43, 92, 
	123, 35, 43, 92, 35, 44, 92, 35, 
	44, 92, 123, 35, 44, 92, 35, 45, 
	92, 35, 45, 92, 123, 35, 45, 92, 
	35, 46, 92, 35, 46, 92, 123, 35, 
	46, 92, 35, 47, 92, 35, 47, 92, 
	123, 35, 47, 92, 35, 58, 92, 35, 
	58, 92, 123, 35, 58, 92, 35, 59, 
	92, 35, 59, 92, 123, 35, 59, 92, 
	35, 62, 92, 35, 62, 92, 123, 35, 
	62, 92, 35, 61, 92, 35, 61, 92, 
	123, 35, 61, 92, 35, 63, 92, 35, 
	63, 92, 123, 35, 63, 92, 35, 64, 
	92, 35, 64, 92, 123, 35, 64, 92, 
	33, 34, 35, 36, 37, 38, 39, 40, 
	42, 43, 44, 45, 46, 47, 58, 59, 
	60, 61, 63, 64, 91, 92, 94, 95, 
	96, 123, 124, 126, 35, 92, 93, 35, 
	92, 93, 123, 35, 92, 93, 35, 92, 
	35, 92, 123, 35, 92, 94, 35, 92, 
	94, 123, 35, 92, 94, 35, 92, 95, 
	35, 92, 95, 123, 35, 92, 95, 35, 
	92, 96, 35, 92, 96, 123, 35, 92, 
	96, 35, 92, 125, 35, 92, 123, 125, 
	35, 92, 125, 35, 92, 124, 35, 92, 
	123, 124, 35, 92, 124, 35, 92, 126, 
	35, 92, 123, 126, 35, 92, 126, 33, 
	34, 35, 36, 37, 38, 39, 40, 42, 
	43, 44, 45, 46, 47, 58, 59, 60, 
	61, 63, 64, 91, 92, 94, 95, 96, 
	123, 124, 126, 33, 92, 33, 92, 34, 
	92, 34, 92, 35, 92, 35, 92, 36, 
	92, 36, 92, 37, 92, 37, 92, 38, 
	92, 38, 92, 39, 92, 39, 92, 41, 
	92, 41, 92, 42, 92, 42, 92, 43, 
	92, 43, 92, 44, 92, 44, 92, 45, 
	92, 45, 92, 46, 92, 46, 92, 47, 
	92, 47, 92, 58, 92, 58, 92, 59, 
	92, 59, 92, 62, 92, 62, 92, 61, 
	92, 61, 92, 63, 92, 63, 92, 64, 
	92, 64, 92, 92, 93, 92, 93, 41, 
	92, 92, 41, 92, 41, 92, 92, 92, 
	92, 94, 92, 94, 92, 95, 92, 95, 
	92, 96, 92, 96, 92, 125, 92, 125, 
	92, 124, 92, 124, 92, 126, 92, 126, 
	34, 39, 45, 95, 65, 90, 97, 122, 
	95, 65, 90, 97, 122, 10, 34, 39, 
	95, 48, 57, 65, 90, 97, 122, 10, 
	34, 39, 95, 65, 90, 97, 122, 103, 
	105, 110, 115, 101, 97, 115, 115, 32, 
	60, 60, 10, 102, 114, 100, 117, 108, 
	108, 116, 101, 115, 115, 105, 108, 105, 
	108, 101, 10, 10, 61, 10, 101, 10, 
	110, 10, 100, 10, 10, 33, 39, 41, 
	47, 58, 59, 61, 64, 92, 96, 124, 
	126, 10, 32, 34, 35, 37, 39, 40, 
	47, 58, 59, 60, 61, 96, 100, 101, 
	116, 123, 125, 65, 90, 95, 122, 61, 
	32, 34, 35, 92, 33, 34, 35, 36, 
	37, 38, 39, 40, 42, 43, 44, 45, 
	46, 47, 58, 59, 60, 61, 63, 64, 
	81, 87, 91, 92, 94, 95, 96, 113, 
	114, 119, 120, 123, 124, 126, 33, 35, 
	92, 123, 35, 92, 123, 35, 36, 92, 
	35, 37, 92, 35, 38, 92, 35, 39, 
	92, 35, 41, 92, 35, 42, 92, 35, 
	43, 92, 35, 44, 92, 35, 45, 92, 
	35, 46, 92, 35, 47, 92, 35, 58, 
	92, 35, 59, 92, 35, 62, 92, 35, 
	61, 92, 35, 63, 92, 35, 64, 92, 
	35, 92, 93, 92, 35, 92, 94, 35, 
	92, 95, 35, 92, 96, 35, 92, 125, 
	35, 92, 124, 35, 92, 126, 33, 92, 
	34, 92, 35, 92, 36, 92, 37, 92, 
	38, 92, 39, 92, 41, 92, 42, 92, 
	43, 92, 44, 92, 45, 92, 46, 92, 
	47, 92, 58, 92, 59, 92, 62, 92, 
	61, 92, 63, 92, 64, 92, 92, 93, 
	41, 92, 92, 92, 94, 92, 95, 92, 
	96, 92, 125, 92, 124, 92, 126, 95, 
	65, 90, 97, 122, 95, 48, 57, 65, 
	90, 97, 122, 60, 62, 58, 95, 48, 
	57, 65, 90, 97, 122, 58, 95, 48, 
	57, 65, 90, 97, 122, 58, 95, 111, 
	48, 57, 65, 90, 97, 122, 58, 95, 
	110, 48, 57, 65, 90, 97, 122, 58, 
	95, 100, 48, 57, 65, 90, 97, 122, 
	58, 95, 104, 48, 57, 65, 90, 97, 
	122, 58, 95, 101, 48, 57, 65, 90, 
	97, 122, 58, 95, 110, 48, 57, 65, 
	90, 97, 122, 32, 98, 99, 100, 102, 
	105, 109, 117, 119, 32, 101, 97, 108, 
	32, 60, 10, 101, 111, 102, 111, 110, 
	104, 10, 10, 10, 10, 10, 10, 33, 
	39, 41, 47, 58, 59, 61, 64, 92, 
	96, 124, 126, 0
]

class << self
	attr_accessor :_proc_scanner_single_lengths
	private :_proc_scanner_single_lengths, :_proc_scanner_single_lengths=
end
self._proc_scanner_single_lengths = [
	0, 1, 1, 1, 1, 1, 1, 3, 
	4, 3, 3, 4, 3, 2, 2, 3, 
	4, 3, 3, 4, 3, 3, 4, 3, 
	3, 4, 3, 3, 4, 3, 3, 4, 
	3, 3, 4, 3, 3, 4, 3, 3, 
	4, 3, 3, 4, 3, 3, 4, 3, 
	3, 4, 3, 3, 4, 3, 3, 4, 
	3, 3, 4, 3, 3, 4, 3, 3, 
	4, 3, 28, 3, 4, 3, 2, 3, 
	3, 4, 3, 3, 4, 3, 3, 4, 
	3, 3, 4, 3, 3, 2, 3, 3, 
	4, 3, 28, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 1, 2, 
	2, 1, 1, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 4, 
	1, 4, 1, 3, 1, 1, 1, 1, 
	1, 1, 1, 1, 2, 1, 1, 1, 
	1, 1, 1, 1, 2, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 2, 2, 
	2, 2, 1, 1, 0, 18, 1, 1, 
	3, 34, 3, 1, 3, 3, 3, 3, 
	3, 3, 3, 3, 3, 3, 3, 3, 
	3, 3, 3, 3, 3, 3, 3, 1, 
	3, 3, 3, 3, 3, 3, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 1, 2, 2, 2, 
	2, 2, 2, 1, 1, 1, 1, 2, 
	2, 3, 3, 3, 3, 3, 3, 9, 
	1, 1, 2, 2, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 0
]

class << self
	attr_accessor :_proc_scanner_range_lengths
	private :_proc_scanner_range_lengths, :_proc_scanner_range_lengths=
end
self._proc_scanner_range_lengths = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 1, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 2, 
	2, 3, 0, 2, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 6, 2, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 2, 3, 0, 0, 3, 
	3, 3, 3, 3, 3, 3, 3, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 6
]

class << self
	attr_accessor :_proc_scanner_index_offsets
	private :_proc_scanner_index_offsets, :_proc_scanner_index_offsets=
end
self._proc_scanner_index_offsets = [
	0, 0, 2, 4, 6, 8, 10, 12, 
	16, 21, 25, 29, 34, 38, 41, 44, 
	48, 53, 57, 61, 66, 70, 74, 79, 
	83, 87, 92, 96, 100, 105, 109, 113, 
	118, 122, 126, 131, 135, 139, 144, 148, 
	152, 157, 161, 165, 170, 174, 178, 183, 
	187, 191, 196, 200, 204, 209, 213, 217, 
	222, 226, 230, 235, 239, 243, 248, 252, 
	256, 261, 265, 294, 298, 303, 307, 310, 
	314, 318, 323, 327, 331, 336, 340, 344, 
	349, 353, 357, 362, 366, 370, 374, 378, 
	382, 387, 391, 420, 423, 426, 429, 432, 
	435, 438, 441, 444, 447, 450, 453, 456, 
	459, 462, 465, 468, 471, 474, 477, 480, 
	483, 486, 489, 492, 495, 498, 501, 504, 
	507, 510, 513, 516, 519, 522, 525, 528, 
	531, 534, 537, 540, 543, 546, 549, 551, 
	554, 557, 559, 561, 564, 567, 570, 573, 
	576, 579, 582, 585, 588, 591, 594, 597, 
	604, 608, 616, 618, 624, 626, 628, 630, 
	632, 634, 636, 638, 640, 643, 645, 647, 
	649, 651, 653, 655, 657, 660, 662, 664, 
	666, 668, 670, 672, 674, 676, 678, 681, 
	684, 687, 690, 692, 694, 701, 722, 724, 
	726, 730, 765, 769, 771, 775, 779, 783, 
	787, 791, 795, 799, 803, 807, 811, 815, 
	819, 823, 827, 831, 835, 839, 843, 847, 
	849, 853, 857, 861, 865, 869, 873, 876, 
	879, 882, 885, 888, 891, 894, 897, 900, 
	903, 906, 909, 912, 915, 918, 921, 924, 
	927, 930, 933, 936, 939, 941, 944, 947, 
	950, 953, 956, 959, 963, 968, 970, 972, 
	978, 984, 991, 998, 1005, 1012, 1019, 1026, 
	1036, 1038, 1040, 1043, 1046, 1048, 1050, 1052, 
	1054, 1056, 1058, 1060, 1062, 1064, 1066, 1068, 
	1070, 1072
]

class << self
	attr_accessor :_proc_scanner_trans_targs
	private :_proc_scanner_trans_targs, :_proc_scanner_trans_targs=
end
self._proc_scanner_trans_targs = [
	2, 189, 3, 189, 4, 189, 5, 189, 
	6, 189, 189, 6, 189, 8, 9, 7, 
	189, 8, 9, 189, 7, 192, 8, 9, 
	7, 189, 11, 12, 10, 189, 11, 12, 
	189, 10, 194, 11, 12, 10, 195, 14, 
	13, 196, 14, 13, 16, 189, 17, 15, 
	16, 189, 17, 189, 15, 16, 197, 17, 
	15, 19, 189, 20, 18, 19, 189, 20, 
	189, 18, 19, 198, 20, 18, 22, 189, 
	23, 21, 22, 189, 23, 189, 21, 22, 
	199, 23, 21, 25, 189, 26, 24, 25, 
	189, 26, 189, 24, 25, 200, 26, 24, 
	28, 189, 29, 27, 28, 189, 29, 189, 
	27, 28, 201, 29, 27, 31, 189, 32, 
	30, 31, 189, 32, 189, 30, 31, 202, 
	32, 30, 34, 189, 35, 33, 34, 189, 
	35, 189, 33, 34, 203, 35, 33, 37, 
	189, 38, 36, 37, 189, 38, 189, 36, 
	37, 204, 38, 36, 40, 189, 41, 39, 
	40, 189, 41, 189, 39, 40, 205, 41, 
	39, 43, 189, 44, 42, 43, 189, 44, 
	189, 42, 43, 206, 44, 42, 46, 189, 
	47, 45, 46, 189, 47, 189, 45, 46, 
	207, 47, 45, 49, 189, 50, 48, 49, 
	189, 50, 189, 48, 49, 208, 50, 48, 
	52, 189, 53, 51, 52, 189, 53, 189, 
	51, 52, 209, 53, 51, 55, 189, 56, 
	54, 55, 189, 56, 189, 54, 55, 210, 
	56, 54, 58, 189, 59, 57, 58, 189, 
	59, 189, 57, 58, 211, 59, 57, 61, 
	189, 62, 60, 61, 189, 62, 189, 60, 
	61, 212, 62, 60, 64, 189, 65, 63, 
	64, 189, 65, 189, 63, 64, 213, 65, 
	63, 10, 7, 13, 15, 18, 21, 24, 
	27, 30, 33, 36, 39, 42, 45, 48, 
	51, 54, 57, 60, 63, 67, 70, 72, 
	75, 78, 81, 84, 87, 189, 68, 69, 
	189, 67, 68, 69, 189, 189, 67, 68, 
	69, 214, 67, 71, 215, 70, 71, 215, 
	189, 70, 73, 74, 189, 72, 73, 74, 
	189, 189, 72, 73, 74, 216, 72, 76, 
	77, 189, 75, 76, 77, 189, 189, 75, 
	76, 77, 217, 75, 79, 80, 189, 78, 
	79, 80, 189, 189, 78, 79, 80, 218, 
	78, 82, 83, 189, 81, 82, 83, 189, 
	189, 81, 82, 83, 219, 81, 85, 86, 
	189, 84, 85, 86, 189, 84, 85, 86, 
	220, 84, 88, 89, 189, 87, 88, 89, 
	189, 189, 87, 88, 89, 221, 87, 91, 
	93, 95, 97, 99, 101, 103, 105, 107, 
	109, 111, 113, 115, 117, 119, 121, 123, 
	125, 127, 129, 131, 133, 139, 141, 143, 
	145, 147, 149, 189, 189, 92, 91, 222, 
	92, 91, 189, 94, 93, 223, 94, 93, 
	189, 96, 95, 224, 96, 95, 189, 98, 
	97, 225, 98, 97, 189, 100, 99, 226, 
	100, 99, 189, 102, 101, 227, 102, 101, 
	189, 104, 103, 228, 104, 103, 189, 106, 
	105, 229, 106, 105, 189, 108, 107, 230, 
	108, 107, 189, 110, 109, 231, 110, 109, 
	189, 112, 111, 232, 112, 111, 189, 114, 
	113, 233, 114, 113, 189, 116, 115, 234, 
	116, 115, 189, 118, 117, 235, 118, 117, 
	189, 120, 119, 236, 120, 119, 189, 122, 
	121, 237, 122, 121, 189, 124, 123, 238, 
	124, 123, 189, 126, 125, 239, 126, 125, 
	189, 128, 127, 240, 128, 127, 189, 130, 
	129, 241, 130, 129, 132, 189, 131, 132, 
	242, 131, 134, 243, 133, 189, 134, 189, 
	136, 135, 189, 137, 135, 244, 138, 243, 
	138, 140, 189, 139, 140, 245, 139, 142, 
	189, 141, 142, 246, 141, 144, 189, 143, 
	144, 247, 143, 146, 189, 145, 146, 248, 
	145, 148, 189, 147, 148, 249, 147, 150, 
	189, 149, 150, 250, 149, 152, 152, 155, 
	153, 153, 153, 189, 153, 153, 153, 189, 
	189, 154, 154, 153, 153, 153, 153, 189, 
	189, 189, 152, 152, 153, 153, 153, 189, 
	157, 263, 158, 263, 263, 263, 160, 263, 
	263, 263, 162, 263, 163, 263, 267, 263, 
	164, 165, 263, 166, 263, 263, 268, 263, 
	263, 263, 263, 170, 263, 171, 263, 160, 
	263, 173, 176, 263, 174, 263, 175, 263, 
	263, 263, 177, 263, 263, 263, 179, 263, 
	180, 263, 263, 263, 182, 181, 182, 183, 
	181, 182, 184, 181, 182, 185, 181, 182, 
	278, 181, 187, 186, 0, 280, 281, 281, 
	281, 281, 281, 281, 188, 190, 191, 192, 
	189, 193, 228, 189, 207, 251, 189, 253, 
	254, 218, 257, 258, 260, 189, 189, 255, 
	256, 189, 1, 189, 191, 189, 189, 8, 
	9, 7, 10, 7, 13, 15, 18, 21, 
	24, 27, 30, 33, 36, 39, 42, 45, 
	48, 51, 54, 57, 60, 63, 66, 66, 
	67, 70, 72, 75, 78, 90, 66, 90, 
	66, 81, 84, 87, 189, 189, 11, 12, 
	10, 189, 189, 195, 14, 189, 13, 16, 
	189, 17, 15, 19, 189, 20, 18, 22, 
	189, 23, 21, 25, 189, 26, 24, 28, 
	189, 29, 27, 31, 189, 32, 30, 34, 
	189, 35, 33, 37, 189, 38, 36, 40, 
	189, 41, 39, 43, 189, 44, 42, 46, 
	189, 47, 45, 49, 189, 50, 48, 52, 
	189, 53, 51, 55, 189, 56, 54, 58, 
	189, 59, 57, 61, 189, 62, 60, 64, 
	189, 65, 63, 68, 69, 189, 67, 70, 
	189, 73, 74, 189, 72, 76, 77, 189, 
	75, 79, 80, 189, 78, 82, 83, 189, 
	81, 85, 86, 189, 84, 88, 89, 189, 
	87, 189, 92, 91, 189, 94, 93, 189, 
	96, 95, 189, 98, 97, 189, 100, 99, 
	189, 102, 101, 189, 104, 103, 189, 106, 
	105, 189, 108, 107, 189, 110, 109, 189, 
	112, 111, 189, 114, 113, 189, 116, 115, 
	189, 118, 117, 189, 120, 119, 189, 122, 
	121, 189, 124, 123, 189, 126, 125, 189, 
	128, 127, 189, 130, 129, 132, 189, 131, 
	189, 137, 135, 244, 138, 140, 189, 139, 
	142, 189, 141, 144, 189, 143, 146, 189, 
	145, 148, 189, 147, 150, 189, 149, 252, 
	252, 252, 189, 252, 252, 252, 252, 189, 
	151, 189, 189, 189, 189, 255, 255, 255, 
	255, 189, 189, 256, 256, 256, 256, 189, 
	189, 256, 256, 256, 256, 256, 189, 189, 
	256, 259, 256, 256, 256, 189, 189, 256, 
	256, 256, 256, 256, 189, 189, 256, 261, 
	256, 256, 256, 189, 189, 256, 262, 256, 
	256, 256, 189, 189, 256, 256, 256, 256, 
	256, 189, 264, 265, 266, 269, 270, 271, 
	272, 273, 274, 263, 264, 263, 156, 263, 
	159, 161, 263, 164, 165, 263, 263, 268, 
	167, 263, 168, 263, 263, 263, 169, 263, 
	172, 263, 178, 263, 0, 276, 275, 276, 
	182, 181, 182, 278, 187, 186, 279, 280, 
	281, 281, 281, 281, 281, 281, 188, 189, 
	189, 189, 189, 189, 189, 189, 189, 189, 
	189, 189, 189, 189, 189, 189, 189, 189, 
	189, 189, 189, 189, 189, 189, 189, 189, 
	189, 189, 189, 189, 189, 189, 189, 189, 
	189, 189, 189, 189, 189, 189, 189, 189, 
	189, 189, 189, 189, 189, 189, 189, 189, 
	189, 189, 189, 189, 189, 189, 189, 189, 
	189, 189, 189, 189, 189, 189, 189, 189, 
	189, 189, 189, 189, 189, 189, 189, 189, 
	189, 189, 189, 189, 189, 189, 189, 189, 
	189, 189, 189, 189, 189, 189, 189, 189, 
	189, 189, 189, 189, 189, 189, 189, 189, 
	189, 189, 189, 189, 189, 189, 189, 189, 
	189, 189, 189, 189, 189, 189, 189, 189, 
	189, 189, 189, 189, 189, 189, 189, 189, 
	189, 189, 189, 189, 189, 189, 189, 189, 
	189, 189, 189, 189, 189, 189, 189, 189, 
	189, 189, 189, 189, 189, 189, 189, 189, 
	189, 189, 189, 189, 189, 189, 189, 189, 
	189, 189, 263, 263, 263, 263, 263, 263, 
	263, 263, 263, 263, 263, 263, 263, 263, 
	263, 263, 263, 263, 263, 263, 263, 263, 
	263, 263, 263, 277, 277, 277, 277, 277, 
	189, 189, 189, 189, 189, 189, 189, 189, 
	189, 189, 189, 189, 189, 189, 189, 189, 
	189, 189, 189, 189, 189, 189, 189, 189, 
	189, 189, 189, 189, 189, 189, 189, 189, 
	189, 189, 189, 189, 189, 189, 189, 189, 
	189, 189, 189, 189, 189, 189, 189, 189, 
	189, 189, 189, 189, 189, 189, 189, 189, 
	189, 189, 189, 189, 189, 189, 189, 189, 
	189, 189, 189, 189, 189, 189, 189, 189, 
	189, 263, 263, 263, 263, 263, 263, 263, 
	263, 263, 263, 263, 275, 277, 279, 0
]

class << self
	attr_accessor :_proc_scanner_trans_actions
	private :_proc_scanner_trans_actions, :_proc_scanner_trans_actions=
end
self._proc_scanner_trans_actions = [
	0, 73, 0, 73, 0, 73, 0, 73, 
	0, 73, 47, 0, 55, 0, 0, 0, 
	55, 0, 0, 55, 0, 108, 0, 0, 
	0, 55, 0, 0, 0, 55, 0, 0, 
	55, 0, 108, 0, 0, 0, 0, 0, 
	0, 108, 0, 0, 0, 55, 0, 0, 
	0, 55, 0, 55, 0, 0, 108, 0, 
	0, 0, 55, 0, 0, 0, 55, 0, 
	55, 0, 0, 108, 0, 0, 0, 55, 
	0, 0, 0, 55, 0, 55, 0, 0, 
	108, 0, 0, 0, 55, 0, 0, 0, 
	55, 0, 55, 0, 0, 108, 0, 0, 
	0, 55, 0, 0, 0, 55, 0, 55, 
	0, 0, 108, 0, 0, 0, 55, 0, 
	0, 0, 55, 0, 55, 0, 0, 108, 
	0, 0, 0, 55, 0, 0, 0, 55, 
	0, 55, 0, 0, 108, 0, 0, 0, 
	55, 0, 0, 0, 55, 0, 55, 0, 
	0, 108, 0, 0, 0, 55, 0, 0, 
	0, 55, 0, 55, 0, 0, 108, 0, 
	0, 0, 55, 0, 0, 0, 55, 0, 
	55, 0, 0, 108, 0, 0, 0, 55, 
	0, 0, 0, 55, 0, 55, 0, 0, 
	108, 0, 0, 0, 55, 0, 0, 0, 
	55, 0, 55, 0, 0, 108, 0, 0, 
	0, 55, 0, 0, 0, 55, 0, 55, 
	0, 0, 108, 0, 0, 0, 55, 0, 
	0, 0, 55, 0, 55, 0, 0, 108, 
	0, 0, 0, 55, 0, 0, 0, 55, 
	0, 55, 0, 0, 108, 0, 0, 0, 
	55, 0, 0, 0, 55, 0, 55, 0, 
	0, 108, 0, 0, 0, 55, 0, 0, 
	0, 55, 0, 55, 0, 0, 108, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 75, 0, 0, 
	55, 0, 0, 0, 55, 55, 0, 0, 
	0, 108, 0, 0, 108, 0, 0, 108, 
	55, 0, 0, 0, 55, 0, 0, 0, 
	55, 55, 0, 0, 0, 108, 0, 0, 
	0, 55, 0, 0, 0, 55, 55, 0, 
	0, 0, 108, 0, 0, 0, 55, 0, 
	0, 0, 55, 55, 0, 0, 0, 108, 
	0, 0, 0, 55, 0, 0, 0, 55, 
	55, 0, 0, 0, 108, 0, 0, 0, 
	55, 0, 0, 0, 55, 0, 0, 0, 
	108, 0, 0, 0, 55, 0, 0, 0, 
	55, 55, 0, 0, 0, 108, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 75, 53, 0, 0, 105, 
	0, 0, 53, 0, 0, 105, 0, 0, 
	53, 0, 0, 105, 0, 0, 53, 0, 
	0, 105, 0, 0, 53, 0, 0, 105, 
	0, 0, 53, 0, 0, 105, 0, 0, 
	53, 0, 0, 105, 0, 0, 53, 0, 
	0, 105, 0, 0, 53, 0, 0, 105, 
	0, 0, 53, 0, 0, 105, 0, 0, 
	53, 0, 0, 105, 0, 0, 53, 0, 
	0, 105, 0, 0, 53, 0, 0, 105, 
	0, 0, 53, 0, 0, 105, 0, 0, 
	53, 0, 0, 105, 0, 0, 53, 0, 
	0, 105, 0, 0, 53, 0, 0, 105, 
	0, 0, 53, 0, 0, 105, 0, 0, 
	53, 0, 0, 105, 0, 0, 53, 0, 
	0, 105, 0, 0, 0, 53, 0, 0, 
	105, 0, 0, 5, 0, 53, 0, 77, 
	0, 0, 77, 0, 0, 5, 0, 5, 
	0, 0, 53, 0, 0, 105, 0, 0, 
	53, 0, 0, 105, 0, 0, 53, 0, 
	0, 105, 0, 0, 53, 0, 0, 105, 
	0, 0, 53, 0, 0, 105, 0, 0, 
	53, 0, 0, 105, 0, 0, 0, 0, 
	0, 0, 0, 75, 0, 0, 0, 75, 
	51, 0, 0, 0, 0, 0, 0, 75, 
	51, 75, 0, 0, 0, 0, 0, 75, 
	0, 21, 0, 21, 9, 21, 0, 21, 
	9, 21, 0, 21, 0, 21, 5, 21, 
	0, 0, 19, 0, 19, 19, 0, 9, 
	21, 7, 21, 0, 21, 0, 21, 0, 
	21, 0, 0, 21, 0, 21, 0, 21, 
	9, 21, 0, 21, 7, 21, 0, 21, 
	0, 21, 7, 21, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	87, 0, 0, 0, 0, 0, 31, 31, 
	31, 31, 31, 31, 0, 5, 0, 102, 
	45, 102, 102, 43, 102, 0, 41, 5, 
	0, 102, 0, 0, 0, 33, 35, 0, 
	99, 49, 0, 57, 0, 65, 55, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 67, 55, 0, 0, 
	0, 55, 71, 0, 0, 55, 0, 0, 
	55, 0, 0, 0, 55, 0, 0, 0, 
	55, 0, 0, 0, 55, 0, 0, 0, 
	55, 0, 0, 0, 55, 0, 0, 0, 
	55, 0, 0, 0, 55, 0, 0, 0, 
	55, 0, 0, 0, 55, 0, 0, 0, 
	55, 0, 0, 0, 55, 0, 0, 0, 
	55, 0, 0, 0, 55, 0, 0, 0, 
	55, 0, 0, 0, 55, 0, 0, 0, 
	55, 0, 0, 0, 0, 55, 0, 0, 
	71, 0, 0, 55, 0, 0, 0, 55, 
	0, 0, 0, 55, 0, 0, 0, 55, 
	0, 0, 0, 55, 0, 0, 0, 55, 
	0, 53, 0, 0, 53, 0, 0, 53, 
	0, 0, 53, 0, 0, 53, 0, 0, 
	53, 0, 0, 53, 0, 0, 53, 0, 
	0, 53, 0, 0, 53, 0, 0, 53, 
	0, 0, 53, 0, 0, 53, 0, 0, 
	53, 0, 0, 53, 0, 0, 53, 0, 
	0, 53, 0, 0, 53, 0, 0, 53, 
	0, 0, 53, 0, 0, 0, 53, 0, 
	69, 0, 0, 5, 0, 0, 53, 0, 
	0, 53, 0, 0, 53, 0, 0, 53, 
	0, 0, 53, 0, 0, 53, 0, 0, 
	0, 0, 67, 0, 0, 0, 0, 63, 
	0, 67, 37, 67, 39, 0, 0, 0, 
	0, 61, 39, 99, 99, 99, 99, 79, 
	39, 99, 90, 99, 99, 99, 59, 39, 
	99, 0, 99, 99, 99, 59, 39, 99, 
	93, 99, 99, 99, 59, 39, 99, 0, 
	99, 99, 99, 59, 39, 99, 0, 99, 
	99, 99, 59, 39, 99, 96, 99, 99, 
	99, 59, 0, 5, 5, 5, 5, 0, 
	5, 5, 5, 11, 0, 15, 0, 17, 
	0, 0, 17, 0, 0, 13, 13, 0, 
	0, 17, 0, 17, 9, 17, 0, 17, 
	0, 17, 0, 17, 0, 84, 23, 84, 
	0, 0, 0, 87, 0, 0, 29, 0, 
	31, 31, 31, 31, 31, 31, 0, 73, 
	73, 73, 73, 73, 73, 79, 79, 79, 
	79, 79, 79, 79, 79, 79, 79, 79, 
	79, 79, 79, 79, 79, 79, 79, 79, 
	79, 79, 79, 79, 79, 79, 79, 79, 
	79, 79, 79, 79, 79, 79, 79, 79, 
	79, 79, 79, 79, 79, 79, 79, 79, 
	79, 79, 79, 79, 79, 79, 79, 79, 
	79, 79, 79, 79, 79, 79, 79, 79, 
	75, 79, 79, 79, 79, 79, 79, 79, 
	79, 79, 79, 79, 79, 79, 79, 79, 
	79, 79, 79, 79, 79, 79, 79, 79, 
	75, 79, 79, 79, 79, 79, 79, 79, 
	79, 79, 79, 79, 79, 79, 79, 79, 
	79, 79, 79, 79, 79, 79, 79, 79, 
	79, 79, 79, 79, 79, 79, 79, 79, 
	79, 79, 79, 79, 79, 79, 79, 79, 
	79, 79, 79, 75, 75, 77, 77, 77, 
	77, 79, 79, 79, 79, 79, 79, 79, 
	79, 79, 79, 79, 79, 75, 75, 75, 
	75, 75, 21, 21, 21, 21, 21, 21, 
	21, 21, 19, 19, 19, 21, 21, 21, 
	21, 21, 21, 21, 21, 21, 21, 21, 
	21, 21, 21, 27, 27, 27, 27, 27, 
	57, 65, 79, 67, 71, 71, 71, 71, 
	71, 71, 71, 71, 71, 71, 71, 71, 
	71, 79, 71, 71, 71, 71, 71, 71, 
	71, 71, 71, 71, 79, 71, 71, 71, 
	69, 69, 69, 69, 69, 69, 79, 69, 
	69, 69, 69, 69, 69, 69, 69, 69, 
	69, 69, 69, 69, 69, 69, 69, 69, 
	69, 69, 69, 69, 69, 67, 63, 67, 
	67, 61, 79, 59, 59, 59, 59, 59, 
	59, 15, 17, 17, 13, 13, 17, 17, 
	17, 17, 17, 17, 23, 25, 29, 0
]

class << self
	attr_accessor :_proc_scanner_to_state_actions
	private :_proc_scanner_to_state_actions, :_proc_scanner_to_state_actions=
end
self._proc_scanner_to_state_actions = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 1, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 1, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 81, 0, 81, 0, 1, 
	0, 1
]

class << self
	attr_accessor :_proc_scanner_from_state_actions
	private :_proc_scanner_from_state_actions, :_proc_scanner_from_state_actions=
end
self._proc_scanner_from_state_actions = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 3, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 3, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 3, 0, 3, 0, 3, 
	0, 3
]

class << self
	attr_accessor :_proc_scanner_eof_trans
	private :_proc_scanner_eof_trans, :_proc_scanner_eof_trans=
end
self._proc_scanner_eof_trans = [
	0, 1085, 1085, 1085, 1085, 1085, 1085, 1331, 
	1331, 1331, 1331, 1331, 1331, 1331, 1331, 1331, 
	1331, 1331, 1331, 1331, 1331, 1331, 1331, 1331, 
	1331, 1331, 1331, 1331, 1331, 1331, 1331, 1331, 
	1331, 1331, 1331, 1331, 1331, 1331, 1331, 1331, 
	1331, 1331, 1331, 1331, 1331, 1331, 1331, 1331, 
	1331, 1331, 1331, 1331, 1331, 1331, 1331, 1331, 
	1331, 1331, 1331, 1331, 1331, 1331, 1331, 1331, 
	1331, 1331, 1234, 1331, 1331, 1331, 1331, 1331, 
	1331, 1331, 1331, 1331, 1331, 1331, 1331, 1331, 
	1331, 1331, 1331, 1331, 1331, 1331, 1331, 1331, 
	1331, 1331, 1234, 1331, 1331, 1331, 1331, 1331, 
	1331, 1331, 1331, 1331, 1331, 1331, 1331, 1331, 
	1331, 1331, 1331, 1331, 1331, 1331, 1331, 1331, 
	1331, 1331, 1331, 1331, 1331, 1331, 1331, 1331, 
	1331, 1331, 1331, 1331, 1331, 1331, 1331, 1331, 
	1331, 1331, 1331, 1331, 1331, 1234, 1234, 1217, 
	1217, 1217, 1217, 1331, 1331, 1331, 1331, 1331, 
	1331, 1331, 1331, 1331, 1331, 1331, 1331, 1234, 
	1234, 1234, 1234, 1234, 1259, 1259, 1259, 1259, 
	1259, 1259, 1259, 1259, 1245, 1245, 1245, 1259, 
	1259, 1259, 1259, 1259, 1259, 1259, 1259, 1259, 
	1259, 1259, 1259, 1259, 1259, 1264, 1264, 1264, 
	1264, 1264, 0, 0, 0, 0, 1265, 1266, 
	1331, 1329, 1296, 1296, 1296, 1296, 1296, 1296, 
	1296, 1296, 1296, 1296, 1296, 1296, 1296, 1331, 
	1296, 1296, 1296, 1296, 1296, 1296, 1296, 1296, 
	1296, 1296, 1331, 1296, 1296, 1296, 1325, 1325, 
	1325, 1325, 1325, 1325, 1331, 1325, 1325, 1325, 
	1325, 1325, 1325, 1325, 1325, 1325, 1325, 1325, 
	1325, 1325, 1325, 1325, 1325, 1325, 1325, 1325, 
	1325, 1325, 1325, 1329, 1327, 1329, 1329, 1330, 
	1331, 1337, 1337, 1337, 1337, 1337, 1337, 0, 
	1338, 1348, 1348, 1342, 1342, 1348, 1348, 1348, 
	1348, 1348, 1348, 0, 1349, 0, 1350, 0, 
	1351, 0
]

class << self
	attr_accessor :proc_scanner_start
end
self.proc_scanner_start = 189;
class << self
	attr_accessor :proc_scanner_first_final
end
self.proc_scanner_first_final = 189;
class << self
	attr_accessor :proc_scanner_error
end
self.proc_scanner_error = 0;

class << self
	attr_accessor :proc_scanner_en_new_statement
end
self.proc_scanner_en_new_statement = 263;
class << self
	attr_accessor :proc_scanner_en_per_line_comment
end
self.proc_scanner_en_per_line_comment = 275;
class << self
	attr_accessor :proc_scanner_en_block_comment
end
self.proc_scanner_en_block_comment = 277;
class << self
	attr_accessor :proc_scanner_en_heredoc
end
self.proc_scanner_en_heredoc = 279;
class << self
	attr_accessor :proc_scanner_en_double_quote_str
end
self.proc_scanner_en_double_quote_str = 281;
class << self
	attr_accessor :proc_scanner_en_main
end
self.proc_scanner_en_main = 189;


# line 278 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"

      extend Scanner::Extensions

      def self.execute!
        data = @data
        eof = data.length
        
# line 2 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rb"
begin
	p ||= 0
	pe ||= data.length
	cs = proc_scanner_start
	ts = nil
	te = nil
	act = 0
end

# line 285 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
        
# line 2 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rb"
begin
	_klen, _trans, _keys, _acts, _nacts = nil
	_goto_level = 0
	_resume = 10
	_eof_trans = 15
	_again = 20
	_test_eof = 30
	_out = 40
	while true
	_trigger_goto = false
	if _goto_level <= 0
	if p == pe
		_goto_level = _test_eof
		next
	end
	if cs == 0
		_goto_level = _out
		next
	end
	end
	if _goto_level <= _resume
	_acts = _proc_scanner_from_state_actions[cs]
	_nacts = _proc_scanner_actions[_acts]
	_acts += 1
	while _nacts > 0
		_nacts -= 1
		_acts += 1
		case _proc_scanner_actions[_acts - 1]
			when 2 then
# line 1 "NONE"
		begin
ts = p
		end
# line 2 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rb"
		end # from state action switch
	end
	if _trigger_goto
		next
	end
	_keys = _proc_scanner_key_offsets[cs]
	_trans = _proc_scanner_index_offsets[cs]
	_klen = _proc_scanner_single_lengths[cs]
	_break_match = false
	
	begin
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + _klen - 1

	     loop do
	        break if _upper < _lower
	        _mid = _lower + ( (_upper - _lower) >> 1 )

	        if data[p] < _proc_scanner_trans_keys[_mid]
	           _upper = _mid - 1
	        elsif data[p] > _proc_scanner_trans_keys[_mid]
	           _lower = _mid + 1
	        else
	           _trans += (_mid - _keys)
	           _break_match = true
	           break
	        end
	     end # loop
	     break if _break_match
	     _keys += _klen
	     _trans += _klen
	  end
	  _klen = _proc_scanner_range_lengths[cs]
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + (_klen << 1) - 2
	     loop do
	        break if _upper < _lower
	        _mid = _lower + (((_upper-_lower) >> 1) & ~1)
	        if data[p] < _proc_scanner_trans_keys[_mid]
	          _upper = _mid - 2
	        elsif data[p] > _proc_scanner_trans_keys[_mid+1]
	          _lower = _mid + 2
	        else
	          _trans += ((_mid - _keys) >> 1)
	          _break_match = true
	          break
	        end
	     end # loop
	     break if _break_match
	     _trans += _klen
	  end
	end while false
	end
	if _goto_level <= _eof_trans
	cs = _proc_scanner_trans_targs[_trans]
	if _proc_scanner_trans_actions[_trans] != 0
		_acts = _proc_scanner_trans_actions[_trans]
		_nacts = _proc_scanner_actions[_acts]
		_acts += 1
		while _nacts > 0
			_nacts -= 1
			_acts += 1
			case _proc_scanner_actions[_acts - 1]
when 3 then
# line 1 "NONE"
		begin
te = p+1
		end
when 4 then
# line 42 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      push(:kw_do_alias2, ts, te)
      increment_counter(:do_end, 0..1)
      	begin
		cs = 189
		_trigger_goto = true
		_goto_level = _again
		break
	end

     end
		end
when 5 then
# line 51 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      push(:kw_do_alias1, ts, te)
      increment_counter(:do_end, 1)
      	begin
		cs = 189
		_trigger_goto = true
		_goto_level = _again
		break
	end

     end
		end
when 6 then
# line 58 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin  p = p - 1; 	begin
		cs = 189
		_trigger_goto = true
		_goto_level = _again
		break
	end
  end
		end
when 7 then
# line 51 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
te = p
p = p - 1; begin 
      push(:kw_do_alias1, ts, te)
      increment_counter(:do_end, 1)
      	begin
		cs = 189
		_trigger_goto = true
		_goto_level = _again
		break
	end

     end
		end
when 8 then
# line 57 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
te = p
p = p - 1; begin  push(:space, ts, te)  end
		end
when 9 then
# line 58 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
te = p
p = p - 1; begin  p = p - 1; 	begin
		cs = 189
		_trigger_goto = true
		_goto_level = _again
		break
	end
  end
		end
when 10 then
# line 51 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
 begin p = ((te))-1; end
 begin 
      push(:kw_do_alias1, ts, te)
      increment_counter(:do_end, 1)
      	begin
		cs = 189
		_trigger_goto = true
		_goto_level = _again
		break
	end

     end
		end
when 11 then
# line 58 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
 begin p = ((te))-1; end
 begin  p = p - 1; 	begin
		cs = 189
		_trigger_goto = true
		_goto_level = _again
		break
	end
  end
		end
when 12 then
# line 64 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
act = 5;		end
when 13 then
# line 1 "NONE"
		begin
	case act
	when 0 then
	begin	begin
		cs = 0
		_trigger_goto = true
		_goto_level = _again
		break
	end
end
	when 5 then
	begin begin p = ((te))-1; end

      push(:comment, ts.pred, te)
      	begin
		cs = 189
		_trigger_goto = true
		_goto_level = _again
		break
	end

    end
end 
			end
when 14 then
# line 72 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
act = 6;		end
when 15 then
# line 72 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
te = p
p = p - 1; begin 
      unless push_comment(ts, te)
        	begin
		cs = 189
		_trigger_goto = true
		_goto_level = _again
		break
	end

      end
     end
		end
when 16 then
# line 1 "NONE"
		begin
	case act
	when 0 then
	begin	begin
		cs = 0
		_trigger_goto = true
		_goto_level = _again
		break
	end
end
	when 6 then
	begin begin p = ((te))-1; end

      unless push_comment(ts, te)
        	begin
		cs = 189
		_trigger_goto = true
		_goto_level = _again
		break
	end

      end
    end
end 
			end
when 17 then
# line 81 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
te = p
p = p - 1; begin 
      unless push_heredoc(ts, te)
        	begin
		cs = 189
		_trigger_goto = true
		_goto_level = _again
		break
	end

      end
     end
		end
when 18 then
# line 91 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      unless push_dstring(ts, te)
        	begin
		cs = 189
		_trigger_goto = true
		_goto_level = _again
		break
	end

      end
     end
		end
when 19 then
# line 103 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
act = 9;		end
when 20 then
# line 109 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
act = 10;		end
when 21 then
# line 154 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
act = 18;		end
when 22 then
# line 173 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
act = 21;		end
when 23 then
# line 177 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
act = 25;		end
when 24 then
# line 225 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
act = 27;		end
when 25 then
# line 268 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
act = 28;		end
when 26 then
# line 116 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      push(:lbrace, ts, te)
      increment_counter(:brace)
     end
		end
when 27 then
# line 121 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      push(:rbrace, ts, te)
      decrement_counter(:brace)
     end
		end
when 28 then
# line 126 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      push(:assoc, ts, te)
      fix_counter_false_start(:brace)
     end
		end
when 29 then
# line 131 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      push_label(ts, te)
      fix_counter_false_start(:brace)
     end
		end
when 30 then
# line 144 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      push(:smcolon, ts, te)
      	begin
		cs = 263
		_trigger_goto = true
		_goto_level = _again
		break
	end

     end
		end
when 31 then
# line 149 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      push(:lparen, ts, te)
      	begin
		cs = 263
		_trigger_goto = true
		_goto_level = _again
		break
	end

     end
		end
when 32 then
# line 161 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      	begin
		cs = 275
		_trigger_goto = true
		_goto_level = _again
		break
	end

     end
		end
when 33 then
# line 165 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      push_comment(ts, te)
      increment_lineno
      	begin
		cs = 277
		_trigger_goto = true
		_goto_level = _again
		break
	end

     end
		end
when 34 then
# line 177 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin  push(:any, ts, te)  end
		end
when 35 then
# line 181 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      push_heredoc(ts, te)
      increment_lineno
      	begin
		cs = 279
		_trigger_goto = true
		_goto_level = _again
		break
	end

     end
		end
when 36 then
# line 225 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      push(:sstring, ts, te)
     end
		end
when 37 then
# line 268 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      if push_dstring(ts, te)
        	begin
		cs = 281
		_trigger_goto = true
		_goto_level = _again
		break
	end

      end
     end
		end
when 38 then
# line 138 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
te = p
p = p - 1; begin 
      push(:newline, ts, te)
      increment_lineno
      	begin
		cs = 263
		_trigger_goto = true
		_goto_level = _again
		break
	end

     end
		end
when 39 then
# line 173 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
te = p
p = p - 1; begin  push(:var, ts, te)  end
		end
when 40 then
# line 174 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
te = p
p = p - 1; begin  push(:const, ts, te)  end
		end
when 41 then
# line 175 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
te = p
p = p - 1; begin  push(:symbol, ts, te)  end
		end
when 42 then
# line 176 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
te = p
p = p - 1; begin  push(:space, ts, te)  end
		end
when 43 then
# line 177 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
te = p
p = p - 1; begin  push(:any, ts, te)  end
		end
when 44 then
# line 225 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
te = p
p = p - 1; begin 
      push(:sstring, ts, te)
     end
		end
when 45 then
# line 268 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
te = p
p = p - 1; begin 
      if push_dstring(ts, te)
        	begin
		cs = 281
		_trigger_goto = true
		_goto_level = _again
		break
	end

      end
     end
		end
when 46 then
# line 138 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
 begin p = ((te))-1; end
 begin 
      push(:newline, ts, te)
      increment_lineno
      	begin
		cs = 263
		_trigger_goto = true
		_goto_level = _again
		break
	end

     end
		end
when 47 then
# line 177 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
 begin p = ((te))-1; end
 begin  push(:any, ts, te)  end
		end
when 48 then
# line 225 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
		begin
 begin p = ((te))-1; end
 begin 
      push(:sstring, ts, te)
     end
		end
when 49 then
# line 1 "NONE"
		begin
	case act
	when 9 then
	begin begin p = ((te))-1; end

      push(:kw_do, ts, te)
      increment_counter(:do_end)
      	begin
		cs = 263
		_trigger_goto = true
		_goto_level = _again
		break
	end

    end
	when 10 then
	begin begin p = ((te))-1; end

      push(:kw_end, ts, te)
      decrement_counter(:do_end)
    end
	when 18 then
	begin begin p = ((te))-1; end

      push(:kw_then, ts, te)
      	begin
		cs = 263
		_trigger_goto = true
		_goto_level = _again
		break
	end

    end
	when 21 then
	begin begin p = ((te))-1; end
 push(:var, ts, te) end
	when 25 then
	begin begin p = ((te))-1; end
 push(:any, ts, te) end
	when 27 then
	begin begin p = ((te))-1; end

      push(:sstring, ts, te)
    end
	when 28 then
	begin begin p = ((te))-1; end

      if push_dstring(ts, te)
        	begin
		cs = 281
		_trigger_goto = true
		_goto_level = _again
		break
	end

      end
    end
end 
			end
# line 2 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rb"
			end # action switch
		end
	end
	if _trigger_goto
		next
	end
	end
	if _goto_level <= _again
	_acts = _proc_scanner_to_state_actions[cs]
	_nacts = _proc_scanner_actions[_acts]
	_acts += 1
	while _nacts > 0
		_nacts -= 1
		_acts += 1
		case _proc_scanner_actions[_acts - 1]
when 0 then
# line 1 "NONE"
		begin
ts = nil;		end
when 1 then
# line 1 "NONE"
		begin
act = 0
		end
# line 2 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rb"
		end # to state action switch
	end
	if _trigger_goto
		next
	end
	if cs == 0
		_goto_level = _out
		next
	end
	p += 1
	if p != pe
		_goto_level = _resume
		next
	end
	end
	if _goto_level <= _test_eof
	if p == eof
	if _proc_scanner_eof_trans[cs] > 0
		_trans = _proc_scanner_eof_trans[cs] - 1;
		_goto_level = _eof_trans
		next;
	end
end
	end
	if _goto_level <= _out
		break
	end
	end
	end

# line 286 "/home/ty.archlinux/dev/ty/sourcify/spec/../lib/sourcify/proc/scanner.rl"
      end

    end
  end
end
