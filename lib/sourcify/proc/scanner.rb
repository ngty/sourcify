
# line 1 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
Sourcify.require_rb('proc', 'scanner', 'extensions')

module Sourcify
  module Proc
    module Scanner #:nodoc:all


# line 458 "./spec/proc/../../lib/sourcify/proc/scanner.rl"


# line 2 "./spec/proc/../../lib/sourcify/proc/scanner.rb"
class << self
	attr_accessor :_proc_scanner_actions
	private :_proc_scanner_actions, :_proc_scanner_actions=
end
self._proc_scanner_actions = [
	0, 1, 0, 1, 2, 1, 3, 1, 
	4, 1, 5, 1, 6, 1, 7, 1, 
	8, 1, 9, 1, 10, 1, 11, 1, 
	13, 1, 15, 1, 16, 1, 17, 1, 
	20, 1, 21, 1, 22, 1, 23, 1, 
	24, 1, 25, 1, 26, 1, 27, 1, 
	28, 1, 29, 1, 30, 1, 31, 1, 
	32, 1, 33, 1, 34, 1, 35, 1, 
	36, 1, 37, 1, 38, 1, 39, 1, 
	40, 1, 41, 1, 42, 1, 43, 1, 
	44, 1, 45, 1, 46, 1, 47, 1, 
	48, 1, 49, 1, 50, 1, 51, 1, 
	52, 1, 53, 1, 54, 1, 55, 1, 
	56, 1, 57, 1, 58, 1, 59, 1, 
	60, 1, 61, 1, 62, 1, 63, 1, 
	64, 1, 65, 1, 66, 1, 67, 1, 
	68, 1, 69, 1, 70, 1, 71, 1, 
	72, 1, 73, 1, 74, 1, 75, 1, 
	76, 1, 77, 1, 78, 1, 79, 1, 
	80, 1, 81, 1, 82, 1, 83, 1, 
	88, 1, 89, 1, 90, 1, 91, 1, 
	92, 1, 93, 1, 94, 1, 95, 1, 
	96, 1, 97, 1, 98, 1, 99, 1, 
	100, 1, 101, 1, 102, 1, 103, 1, 
	104, 1, 105, 1, 106, 1, 107, 1, 
	108, 1, 109, 1, 110, 2, 0, 1, 
	2, 3, 12, 2, 3, 14, 2, 3, 
	18, 2, 3, 19, 2, 3, 84, 2, 
	3, 85, 2, 3, 86, 2, 3, 87
]

class << self
	attr_accessor :_proc_scanner_key_offsets
	private :_proc_scanner_key_offsets, :_proc_scanner_key_offsets=
end
self._proc_scanner_key_offsets = [
	0, 0, 1, 2, 3, 4, 5, 6, 
	7, 11, 19, 24, 35, 36, 37, 41, 
	51, 58, 62, 63, 64, 65, 72, 73, 
	74, 75, 76, 77, 89, 94, 95, 96, 
	97, 98, 105, 106, 107, 108, 110, 111, 
	112, 113, 114, 115, 116, 117, 118, 119, 
	121, 123, 125, 127, 128, 129, 157, 185, 
	187, 188, 189, 191, 193, 195, 196, 197, 
	199, 201, 203, 204, 205, 207, 209, 211, 
	212, 213, 215, 217, 219, 220, 221, 223, 
	225, 227, 228, 229, 231, 233, 235, 236, 
	237, 239, 241, 243, 244, 245, 247, 249, 
	251, 252, 253, 255, 257, 259, 260, 261, 
	263, 265, 267, 268, 269, 271, 273, 275, 
	276, 277, 279, 281, 283, 284, 285, 287, 
	289, 291, 292, 293, 295, 297, 299, 300, 
	301, 303, 305, 307, 308, 309, 311, 313, 
	315, 316, 317, 319, 321, 323, 324, 325, 
	327, 329, 331, 332, 333, 335, 337, 339, 
	340, 341, 343, 345, 347, 348, 349, 351, 
	353, 355, 356, 358, 360, 361, 362, 364, 
	365, 366, 368, 370, 372, 373, 374, 376, 
	378, 380, 381, 382, 384, 386, 388, 389, 
	390, 392, 394, 396, 397, 398, 400, 402, 
	404, 405, 406, 408, 410, 411, 412, 413, 
	414, 415, 416, 417, 418, 419, 420, 421, 
	422, 423, 424, 425, 426, 427, 428, 429, 
	430, 431, 432, 433, 434, 435, 436, 437, 
	438, 463, 467, 468, 473, 481, 488, 489, 
	490, 498, 499, 507, 516, 525, 534, 543, 
	552, 561, 573, 577, 578, 580, 585, 586, 
	587, 588, 589, 590, 591, 592, 593, 594, 
	595, 596, 597, 598, 599, 604, 638, 640, 
	642, 644, 646, 648, 650, 652, 654, 656, 
	658, 660, 662, 664, 666, 668, 670, 672, 
	674, 676, 678, 680, 682, 683, 685, 687, 
	689, 691, 693, 695, 697, 698, 699, 700, 
	701, 702, 703, 704, 705, 706, 707, 708, 
	709, 710, 711, 712, 713, 714, 715, 716, 
	717, 718, 719, 720, 721, 722, 723, 724
]

class << self
	attr_accessor :_proc_scanner_trans_keys
	private :_proc_scanner_trans_keys, :_proc_scanner_trans_keys=
end
self._proc_scanner_trans_keys = [
	98, 101, 103, 105, 110, 10, 58, 65, 
	90, 97, 122, 34, 39, 45, 95, 65, 
	90, 97, 122, 95, 65, 90, 97, 122, 
	10, 34, 39, 58, 95, 48, 57, 65, 
	90, 97, 122, 10, 58, 65, 90, 97, 
	122, 10, 34, 39, 95, 48, 57, 65, 
	90, 97, 122, 34, 39, 95, 65, 90, 
	97, 122, 65, 90, 97, 122, 103, 105, 
	110, 95, 48, 57, 65, 90, 97, 122, 
	115, 101, 97, 115, 115, 9, 32, 60, 
	95, 11, 13, 48, 57, 65, 90, 97, 
	122, 9, 32, 60, 11, 13, 60, 10, 
	102, 114, 95, 48, 57, 65, 90, 97, 
	122, 100, 117, 108, 108, 116, 101, 115, 
	115, 105, 108, 105, 108, 101, 10, 10, 
	61, 10, 101, 10, 110, 10, 100, 10, 
	10, 33, 34, 35, 36, 37, 38, 39, 
	40, 42, 43, 44, 45, 46, 47, 58, 
	59, 60, 61, 63, 64, 91, 92, 94, 
	95, 96, 123, 124, 126, 33, 34, 35, 
	36, 37, 38, 39, 40, 42, 43, 44, 
	45, 46, 47, 58, 59, 60, 61, 63, 
	64, 91, 92, 94, 95, 96, 123, 124, 
	126, 33, 92, 33, 33, 33, 92, 33, 
	92, 34, 92, 34, 34, 34, 92, 34, 
	92, 35, 92, 35, 35, 35, 92, 35, 
	92, 36, 92, 36, 36, 36, 92, 36, 
	92, 37, 92, 37, 37, 37, 92, 37, 
	92, 38, 92, 38, 38, 38, 92, 38, 
	92, 39, 92, 39, 39, 39, 92, 39, 
	92, 41, 92, 41, 41, 41, 92, 41, 
	92, 42, 92, 42, 42, 42, 92, 42, 
	92, 43, 92, 43, 43, 43, 92, 43, 
	92, 44, 92, 44, 44, 44, 92, 44, 
	92, 45, 92, 45, 45, 45, 92, 45, 
	92, 46, 92, 46, 46, 46, 92, 46, 
	92, 47, 92, 47, 47, 47, 92, 47, 
	92, 58, 92, 58, 58, 58, 92, 58, 
	92, 59, 92, 59, 59, 59, 92, 59, 
	92, 62, 92, 62, 62, 62, 92, 62, 
	92, 61, 92, 61, 61, 61, 92, 61, 
	92, 63, 92, 63, 63, 63, 92, 63, 
	92, 64, 92, 64, 64, 64, 92, 64, 
	92, 92, 93, 93, 93, 92, 93, 92, 
	93, 41, 92, 92, 41, 92, 41, 92, 
	92, 92, 92, 94, 94, 94, 92, 94, 
	92, 94, 92, 95, 95, 95, 92, 95, 
	92, 95, 92, 96, 96, 96, 92, 96, 
	92, 96, 92, 125, 125, 125, 92, 125, 
	92, 125, 92, 124, 124, 124, 92, 124, 
	92, 124, 92, 126, 126, 126, 92, 126, 
	92, 126, 34, 39, 47, 96, 126, 33, 
	64, 35, 36, 37, 94, 38, 42, 45, 
	95, 43, 61, 62, 124, 58, 59, 44, 
	46, 63, 125, 93, 41, 92, 10, 32, 
	34, 35, 37, 39, 40, 44, 47, 58, 
	59, 60, 61, 96, 100, 101, 116, 123, 
	125, 9, 13, 65, 90, 95, 122, 9, 
	32, 11, 13, 61, 95, 65, 90, 97, 
	122, 58, 95, 48, 57, 65, 90, 97, 
	122, 95, 48, 57, 65, 90, 97, 122, 
	60, 62, 58, 95, 48, 57, 65, 90, 
	97, 122, 58, 58, 95, 48, 57, 65, 
	90, 97, 122, 58, 95, 111, 48, 57, 
	65, 90, 97, 122, 58, 95, 110, 48, 
	57, 65, 90, 97, 122, 58, 95, 100, 
	48, 57, 65, 90, 97, 122, 58, 95, 
	104, 48, 57, 65, 90, 97, 122, 58, 
	95, 101, 48, 57, 65, 90, 97, 122, 
	58, 95, 110, 48, 57, 65, 90, 97, 
	122, 9, 32, 98, 99, 100, 102, 105, 
	109, 117, 119, 11, 13, 9, 32, 11, 
	13, 101, 97, 108, 9, 32, 60, 11, 
	13, 10, 60, 101, 111, 102, 111, 110, 
	104, 10, 10, 10, 10, 10, 10, 34, 
	37, 39, 47, 96, 33, 34, 35, 36, 
	37, 38, 39, 40, 42, 43, 44, 45, 
	46, 47, 58, 59, 60, 61, 63, 64, 
	81, 87, 91, 92, 94, 95, 96, 113, 
	114, 119, 120, 123, 124, 126, 33, 92, 
	34, 92, 35, 92, 36, 92, 37, 92, 
	38, 92, 39, 92, 41, 92, 42, 92, 
	43, 92, 44, 92, 45, 92, 46, 92, 
	47, 92, 58, 92, 59, 92, 62, 92, 
	61, 92, 63, 92, 64, 92, 92, 93, 
	41, 92, 92, 92, 94, 92, 95, 92, 
	96, 92, 125, 92, 124, 92, 126, 39, 
	92, 34, 39, 47, 96, 126, 33, 64, 
	35, 36, 37, 94, 38, 42, 45, 95, 
	43, 61, 62, 124, 58, 59, 44, 46, 
	63, 125, 93, 41, 92, 0
]

class << self
	attr_accessor :_proc_scanner_single_lengths
	private :_proc_scanner_single_lengths, :_proc_scanner_single_lengths=
end
self._proc_scanner_single_lengths = [
	0, 1, 1, 1, 1, 1, 1, 1, 
	0, 4, 1, 5, 1, 1, 0, 4, 
	3, 0, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 4, 3, 1, 1, 1, 
	1, 1, 1, 1, 1, 2, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 2, 
	2, 2, 2, 1, 1, 28, 28, 2, 
	1, 1, 2, 2, 2, 1, 1, 2, 
	2, 2, 1, 1, 2, 2, 2, 1, 
	1, 2, 2, 2, 1, 1, 2, 2, 
	2, 1, 1, 2, 2, 2, 1, 1, 
	2, 2, 2, 1, 1, 2, 2, 2, 
	1, 1, 2, 2, 2, 1, 1, 2, 
	2, 2, 1, 1, 2, 2, 2, 1, 
	1, 2, 2, 2, 1, 1, 2, 2, 
	2, 1, 1, 2, 2, 2, 1, 1, 
	2, 2, 2, 1, 1, 2, 2, 2, 
	1, 1, 2, 2, 2, 1, 1, 2, 
	2, 2, 1, 1, 2, 2, 2, 1, 
	1, 2, 2, 2, 1, 1, 2, 2, 
	2, 1, 2, 2, 1, 1, 2, 1, 
	1, 2, 2, 2, 1, 1, 2, 2, 
	2, 1, 1, 2, 2, 2, 1, 1, 
	2, 2, 2, 1, 1, 2, 2, 2, 
	1, 1, 2, 2, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	19, 2, 1, 1, 2, 1, 1, 1, 
	2, 1, 2, 3, 3, 3, 3, 3, 
	3, 10, 2, 1, 2, 3, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 5, 34, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 1, 2, 2, 2, 
	2, 2, 2, 2, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1
]

class << self
	attr_accessor :_proc_scanner_range_lengths
	private :_proc_scanner_range_lengths, :_proc_scanner_range_lengths=
end
self._proc_scanner_range_lengths = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	2, 2, 2, 3, 0, 0, 2, 3, 
	2, 2, 0, 0, 0, 3, 0, 0, 
	0, 0, 0, 4, 1, 0, 0, 0, 
	0, 3, 0, 0, 0, 0, 0, 0, 
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
	3, 1, 0, 2, 3, 3, 0, 0, 
	3, 0, 3, 3, 3, 3, 3, 3, 
	3, 1, 1, 0, 0, 1, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0
]

class << self
	attr_accessor :_proc_scanner_index_offsets
	private :_proc_scanner_index_offsets, :_proc_scanner_index_offsets=
end
self._proc_scanner_index_offsets = [
	0, 0, 2, 4, 6, 8, 10, 12, 
	14, 17, 24, 28, 37, 39, 41, 44, 
	52, 58, 61, 63, 65, 67, 72, 74, 
	76, 78, 80, 82, 91, 96, 98, 100, 
	102, 104, 109, 111, 113, 115, 118, 120, 
	122, 124, 126, 128, 130, 132, 134, 136, 
	139, 142, 145, 148, 150, 152, 181, 210, 
	213, 215, 217, 220, 223, 226, 228, 230, 
	233, 236, 239, 241, 243, 246, 249, 252, 
	254, 256, 259, 262, 265, 267, 269, 272, 
	275, 278, 280, 282, 285, 288, 291, 293, 
	295, 298, 301, 304, 306, 308, 311, 314, 
	317, 319, 321, 324, 327, 330, 332, 334, 
	337, 340, 343, 345, 347, 350, 353, 356, 
	358, 360, 363, 366, 369, 371, 373, 376, 
	379, 382, 384, 386, 389, 392, 395, 397, 
	399, 402, 405, 408, 410, 412, 415, 418, 
	421, 423, 425, 428, 431, 434, 436, 438, 
	441, 444, 447, 449, 451, 454, 457, 460, 
	462, 464, 467, 470, 473, 475, 477, 480, 
	483, 486, 488, 491, 494, 496, 498, 501, 
	503, 505, 508, 511, 514, 516, 518, 521, 
	524, 527, 529, 531, 534, 537, 540, 542, 
	544, 547, 550, 553, 555, 557, 560, 563, 
	566, 568, 570, 573, 576, 578, 580, 582, 
	584, 586, 588, 590, 592, 594, 596, 598, 
	600, 602, 604, 606, 608, 610, 612, 614, 
	616, 618, 620, 622, 624, 626, 628, 630, 
	632, 655, 659, 661, 665, 671, 676, 678, 
	680, 686, 688, 694, 701, 708, 715, 722, 
	729, 736, 748, 752, 754, 757, 762, 764, 
	766, 768, 770, 772, 774, 776, 778, 780, 
	782, 784, 786, 788, 790, 796, 831, 834, 
	837, 840, 843, 846, 849, 852, 855, 858, 
	861, 864, 867, 870, 873, 876, 879, 882, 
	885, 888, 891, 894, 897, 899, 902, 905, 
	908, 911, 914, 917, 920, 922, 924, 926, 
	928, 930, 932, 934, 936, 938, 940, 942, 
	944, 946, 948, 950, 952, 954, 956, 958, 
	960, 962, 964, 966, 968, 970, 972, 974
]

class << self
	attr_accessor :_proc_scanner_indicies
	private :_proc_scanner_indicies, :_proc_scanner_indicies=
end
self._proc_scanner_indicies = [
	1, 0, 2, 0, 3, 0, 4, 0, 
	5, 0, 6, 5, 8, 7, 9, 9, 
	7, 11, 11, 12, 14, 13, 14, 10, 
	14, 13, 14, 10, 15, 16, 16, 17, 
	13, 13, 13, 13, 10, 15, 10, 18, 
	10, 13, 13, 10, 15, 16, 16, 14, 
	14, 14, 14, 10, 11, 11, 14, 13, 
	14, 10, 20, 20, 19, 22, 21, 23, 
	21, 24, 21, 21, 21, 21, 21, 25, 
	26, 21, 24, 21, 27, 21, 28, 21, 
	29, 21, 30, 30, 31, 21, 30, 21, 
	21, 21, 25, 33, 33, 34, 33, 32, 
	35, 32, 32, 36, 24, 21, 37, 21, 
	21, 21, 21, 21, 38, 39, 21, 40, 
	21, 26, 21, 41, 42, 21, 43, 21, 
	44, 21, 24, 21, 45, 21, 37, 21, 
	46, 21, 47, 21, 37, 21, 50, 49, 
	50, 51, 49, 50, 52, 49, 50, 53, 
	49, 50, 54, 49, 56, 55, 58, 57, 
	60, 61, 62, 63, 64, 65, 66, 67, 
	68, 69, 70, 71, 72, 73, 74, 75, 
	76, 77, 78, 79, 80, 81, 82, 83, 
	84, 85, 86, 87, 59, 88, 89, 90, 
	91, 92, 93, 94, 95, 96, 97, 98, 
	99, 100, 101, 102, 103, 104, 105, 106, 
	107, 108, 109, 110, 111, 112, 113, 114, 
	115, 59, 116, 117, 88, 119, 118, 116, 
	118, 116, 122, 121, 119, 122, 121, 116, 
	123, 89, 125, 124, 116, 124, 116, 127, 
	126, 125, 127, 126, 116, 128, 90, 130, 
	129, 116, 129, 116, 132, 131, 130, 132, 
	131, 116, 133, 91, 135, 134, 116, 134, 
	116, 137, 136, 135, 137, 136, 116, 138, 
	92, 140, 139, 116, 139, 116, 142, 141, 
	140, 142, 141, 116, 143, 93, 145, 144, 
	116, 144, 116, 147, 146, 145, 147, 146, 
	116, 149, 94, 151, 150, 116, 150, 116, 
	153, 152, 151, 153, 152, 116, 154, 95, 
	156, 155, 116, 155, 116, 158, 157, 156, 
	158, 157, 116, 159, 96, 161, 160, 116, 
	160, 116, 163, 162, 161, 163, 162, 116, 
	164, 97, 166, 165, 116, 165, 116, 168, 
	167, 166, 168, 167, 116, 169, 98, 171, 
	170, 116, 170, 116, 173, 172, 171, 173, 
	172, 116, 174, 99, 176, 175, 116, 175, 
	116, 178, 177, 176, 178, 177, 116, 179, 
	100, 181, 180, 116, 180, 116, 183, 182, 
	181, 183, 182, 116, 184, 101, 186, 185, 
	116, 185, 116, 188, 187, 186, 188, 187, 
	116, 189, 102, 191, 190, 116, 190, 116, 
	193, 192, 191, 193, 192, 116, 194, 103, 
	196, 195, 116, 195, 116, 198, 197, 196, 
	198, 197, 116, 199, 104, 201, 200, 116, 
	200, 116, 203, 202, 201, 203, 202, 116, 
	204, 105, 206, 205, 116, 205, 116, 208, 
	207, 206, 208, 207, 116, 209, 106, 211, 
	210, 116, 210, 116, 213, 212, 211, 213, 
	212, 116, 214, 107, 216, 215, 116, 215, 
	116, 218, 217, 216, 218, 217, 219, 116, 
	108, 221, 220, 116, 220, 223, 116, 222, 
	223, 221, 222, 224, 225, 109, 116, 224, 
	120, 227, 226, 120, 228, 226, 230, 229, 
	225, 229, 231, 116, 110, 233, 232, 116, 
	232, 235, 116, 234, 235, 233, 234, 236, 
	116, 111, 238, 237, 116, 237, 240, 116, 
	239, 240, 238, 239, 241, 116, 112, 243, 
	242, 116, 242, 245, 116, 244, 245, 243, 
	244, 246, 116, 113, 248, 247, 116, 247, 
	250, 116, 249, 250, 248, 249, 251, 116, 
	114, 253, 252, 116, 252, 255, 116, 254, 
	255, 253, 254, 256, 116, 115, 258, 257, 
	116, 257, 260, 116, 259, 260, 258, 259, 
	262, 261, 264, 263, 266, 265, 268, 267, 
	270, 269, 272, 271, 274, 273, 276, 275, 
	278, 277, 280, 279, 282, 281, 284, 283, 
	286, 285, 288, 287, 290, 289, 292, 291, 
	294, 293, 296, 295, 298, 297, 300, 299, 
	302, 301, 304, 303, 306, 305, 308, 307, 
	310, 309, 312, 311, 314, 313, 316, 315, 
	319, 318, 320, 321, 320, 320, 322, 322, 
	320, 323, 322, 324, 325, 320, 327, 328, 
	329, 330, 331, 318, 20, 326, 317, 318, 
	318, 318, 332, 334, 333, 336, 9, 336, 
	335, 338, 9, 9, 9, 9, 337, 336, 
	336, 336, 336, 337, 339, 335, 341, 340, 
	343, 20, 20, 20, 20, 342, 345, 344, 
	347, 326, 326, 326, 326, 346, 347, 326, 
	349, 326, 326, 326, 348, 347, 326, 350, 
	326, 326, 326, 348, 347, 326, 351, 326, 
	326, 326, 348, 347, 326, 352, 326, 326, 
	326, 348, 347, 326, 353, 326, 326, 326, 
	348, 347, 326, 354, 326, 326, 326, 348, 
	356, 356, 357, 358, 359, 360, 361, 362, 
	363, 364, 356, 355, 356, 356, 356, 365, 
	367, 366, 368, 369, 366, 33, 33, 34, 
	33, 370, 370, 36, 35, 370, 371, 366, 
	372, 366, 24, 366, 373, 366, 374, 366, 
	375, 366, 58, 376, 377, 376, 50, 49, 
	50, 54, 56, 55, 379, 57, 61, 381, 
	382, 73, 84, 380, 60, 61, 62, 63, 
	64, 65, 66, 67, 68, 69, 70, 71, 
	72, 73, 74, 75, 76, 77, 78, 79, 
	384, 384, 80, 81, 82, 83, 84, 385, 
	384, 385, 384, 85, 86, 87, 383, 116, 
	122, 121, 116, 127, 126, 116, 132, 131, 
	116, 137, 136, 116, 142, 141, 116, 147, 
	146, 116, 153, 152, 116, 158, 157, 116, 
	163, 162, 116, 168, 167, 116, 173, 172, 
	116, 178, 177, 116, 183, 182, 116, 188, 
	187, 116, 193, 192, 116, 198, 197, 116, 
	203, 202, 116, 208, 207, 116, 213, 212, 
	116, 218, 217, 223, 116, 222, 386, 228, 
	226, 230, 229, 235, 116, 234, 240, 116, 
	239, 245, 116, 244, 250, 116, 249, 255, 
	116, 254, 260, 116, 259, 116, 149, 94, 
	262, 261, 264, 263, 266, 265, 268, 267, 
	270, 269, 272, 271, 274, 273, 276, 275, 
	278, 277, 280, 279, 282, 281, 284, 283, 
	286, 285, 288, 287, 290, 289, 292, 291, 
	294, 293, 296, 295, 298, 297, 300, 299, 
	302, 301, 304, 303, 306, 305, 308, 307, 
	310, 309, 312, 311, 314, 313, 316, 315, 
	0
]

class << self
	attr_accessor :_proc_scanner_trans_targs
	private :_proc_scanner_trans_targs, :_proc_scanner_trans_targs=
end
self._proc_scanner_trans_targs = [
	224, 2, 3, 4, 5, 6, 224, 224, 
	8, 228, 224, 10, 16, 11, 15, 224, 
	12, 13, 14, 224, 232, 241, 19, 20, 
	21, 241, 23, 25, 26, 27, 245, 247, 
	241, 28, 29, 30, 246, 33, 241, 35, 
	36, 38, 41, 39, 40, 42, 44, 45, 
	256, 46, 47, 48, 49, 50, 257, 51, 
	52, 259, 0, 260, 260, 260, 260, 260, 
	260, 260, 260, 260, 260, 260, 260, 260, 
	260, 260, 260, 260, 260, 260, 260, 260, 
	260, 260, 260, 260, 260, 260, 260, 260, 
	55, 60, 65, 70, 75, 80, 85, 90, 
	95, 100, 105, 110, 115, 120, 125, 130, 
	135, 140, 145, 150, 155, 160, 166, 171, 
	176, 181, 186, 191, 260, 56, 57, 262, 
	260, 58, 59, 61, 62, 263, 63, 64, 
	66, 67, 264, 68, 69, 71, 72, 265, 
	73, 74, 76, 77, 266, 78, 79, 81, 
	82, 267, 83, 84, 260, 86, 87, 268, 
	88, 89, 91, 92, 269, 93, 94, 96, 
	97, 270, 98, 99, 101, 102, 271, 103, 
	104, 106, 107, 272, 108, 109, 111, 112, 
	273, 113, 114, 116, 117, 274, 118, 119, 
	121, 122, 275, 123, 124, 126, 127, 276, 
	128, 129, 131, 132, 277, 133, 134, 136, 
	137, 278, 138, 139, 141, 142, 279, 143, 
	144, 146, 147, 280, 148, 149, 151, 152, 
	281, 153, 154, 156, 157, 282, 158, 159, 
	161, 283, 162, 163, 164, 165, 284, 167, 
	168, 285, 169, 170, 172, 173, 286, 174, 
	175, 177, 178, 287, 179, 180, 182, 183, 
	288, 184, 185, 187, 188, 289, 189, 190, 
	192, 193, 290, 194, 195, 196, 292, 197, 
	293, 198, 294, 199, 295, 200, 296, 201, 
	297, 202, 298, 203, 299, 204, 300, 205, 
	301, 206, 302, 207, 303, 208, 304, 209, 
	305, 210, 306, 211, 307, 212, 308, 213, 
	309, 214, 310, 215, 311, 216, 312, 217, 
	313, 218, 314, 219, 315, 220, 316, 221, 
	317, 222, 318, 223, 319, 224, 225, 226, 
	224, 224, 224, 227, 230, 231, 234, 235, 
	236, 238, 224, 224, 224, 224, 1, 224, 
	229, 224, 7, 9, 224, 224, 224, 233, 
	224, 17, 224, 224, 224, 234, 237, 234, 
	239, 240, 234, 241, 242, 243, 244, 248, 
	249, 250, 251, 252, 253, 241, 241, 18, 
	22, 24, 241, 31, 32, 34, 37, 43, 
	255, 254, 256, 258, 260, 261, 291, 260, 
	53, 54, 260, 260
]

class << self
	attr_accessor :_proc_scanner_trans_actions
	private :_proc_scanner_trans_actions, :_proc_scanner_trans_actions=
end
self._proc_scanner_trans_actions = [
	197, 0, 0, 0, 0, 0, 171, 199, 
	0, 5, 201, 0, 0, 0, 0, 173, 
	0, 0, 0, 195, 0, 21, 0, 0, 
	0, 9, 0, 0, 0, 0, 5, 5, 
	19, 0, 0, 0, 0, 0, 7, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	27, 0, 0, 0, 0, 0, 211, 0, 
	0, 0, 0, 99, 43, 33, 47, 49, 
	51, 55, 35, 85, 57, 63, 75, 59, 
	77, 37, 71, 73, 67, 65, 79, 45, 
	83, 87, 53, 61, 39, 81, 69, 41, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 31, 0, 0, 5, 
	97, 0, 0, 0, 0, 5, 0, 0, 
	0, 0, 5, 0, 0, 0, 0, 5, 
	0, 0, 0, 0, 5, 0, 0, 0, 
	0, 5, 0, 0, 101, 0, 0, 5, 
	0, 0, 0, 0, 5, 0, 0, 0, 
	0, 5, 0, 0, 0, 0, 5, 0, 
	0, 0, 0, 5, 0, 0, 0, 0, 
	5, 0, 0, 0, 0, 5, 0, 0, 
	0, 0, 5, 0, 0, 0, 0, 5, 
	0, 0, 0, 0, 5, 0, 0, 0, 
	0, 5, 0, 0, 0, 0, 5, 0, 
	0, 0, 0, 5, 0, 0, 0, 0, 
	5, 0, 0, 0, 0, 5, 0, 0, 
	0, 5, 0, 0, 0, 0, 5, 0, 
	0, 5, 0, 0, 0, 0, 5, 0, 
	0, 0, 0, 5, 0, 0, 0, 0, 
	5, 0, 0, 0, 0, 5, 0, 0, 
	0, 0, 5, 0, 0, 0, 103, 0, 
	105, 0, 107, 0, 109, 0, 111, 0, 
	113, 0, 115, 0, 117, 0, 119, 0, 
	121, 0, 123, 0, 125, 0, 127, 0, 
	129, 0, 131, 0, 133, 0, 135, 0, 
	137, 0, 139, 0, 141, 0, 143, 0, 
	145, 0, 147, 0, 149, 0, 151, 0, 
	153, 0, 155, 0, 157, 177, 0, 5, 
	175, 169, 167, 0, 5, 0, 229, 0, 
	0, 0, 159, 161, 191, 181, 0, 193, 
	0, 189, 0, 0, 183, 163, 187, 5, 
	179, 0, 203, 165, 185, 220, 0, 223, 
	0, 0, 226, 11, 0, 5, 5, 5, 
	5, 5, 5, 5, 5, 15, 17, 0, 
	0, 0, 13, 0, 0, 0, 0, 0, 
	208, 23, 25, 29, 89, 217, 214, 95, 
	0, 0, 91, 93
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
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	1, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 1, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 205, 0, 
	205, 0, 1, 0, 1, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1
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
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	3, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 3, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 3, 0, 
	3, 0, 3, 0, 3, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 3, 3, 3, 3, 
	3, 3, 3, 3, 3, 3, 3, 3, 
	3, 3, 3, 3, 3, 3, 3, 3, 
	3, 3, 3, 3, 3, 3, 3, 3
]

class << self
	attr_accessor :_proc_scanner_eof_trans
	private :_proc_scanner_eof_trans, :_proc_scanner_eof_trans=
end
self._proc_scanner_eof_trans = [
	0, 1, 1, 1, 1, 1, 1, 8, 
	8, 11, 11, 11, 11, 11, 11, 11, 
	11, 20, 22, 22, 22, 22, 22, 22, 
	22, 22, 22, 22, 33, 33, 33, 22, 
	22, 22, 22, 22, 22, 22, 22, 22, 
	22, 22, 22, 22, 22, 22, 49, 49, 
	49, 49, 49, 0, 0, 60, 60, 60, 
	60, 60, 121, 121, 60, 60, 60, 121, 
	121, 60, 60, 60, 121, 121, 60, 60, 
	60, 121, 121, 60, 60, 60, 121, 121, 
	60, 60, 60, 121, 121, 149, 149, 149, 
	121, 121, 60, 60, 60, 121, 121, 60, 
	60, 60, 121, 121, 60, 60, 60, 121, 
	121, 60, 60, 60, 121, 121, 60, 60, 
	60, 121, 121, 60, 60, 60, 121, 121, 
	60, 60, 60, 121, 121, 60, 60, 60, 
	121, 121, 60, 60, 60, 121, 121, 60, 
	60, 60, 121, 121, 60, 60, 60, 121, 
	121, 60, 60, 60, 121, 121, 60, 60, 
	60, 121, 121, 60, 60, 60, 121, 121, 
	60, 60, 121, 121, 121, 121, 60, 60, 
	60, 121, 121, 60, 60, 60, 121, 121, 
	60, 60, 60, 121, 121, 60, 60, 60, 
	121, 121, 60, 60, 60, 121, 121, 60, 
	60, 60, 121, 121, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 333, 334, 336, 338, 338, 336, 341, 
	343, 345, 347, 349, 349, 349, 349, 349, 
	349, 0, 366, 367, 367, 371, 371, 371, 
	367, 367, 367, 367, 367, 367, 0, 378, 
	0, 379, 0, 380, 0, 384, 387, 387, 
	387, 387, 387, 387, 387, 387, 387, 387, 
	387, 387, 387, 387, 387, 387, 387, 387, 
	387, 387, 387, 387, 387, 387, 387, 387, 
	387, 387, 387, 388, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0
]

class << self
	attr_accessor :proc_scanner_start
end
self.proc_scanner_start = 224;
class << self
	attr_accessor :proc_scanner_first_final
end
self.proc_scanner_first_final = 224;
class << self
	attr_accessor :proc_scanner_error
end
self.proc_scanner_error = 0;

class << self
	attr_accessor :proc_scanner_en_new_statement
end
self.proc_scanner_en_new_statement = 241;
class << self
	attr_accessor :proc_scanner_en_per_line_comment
end
self.proc_scanner_en_per_line_comment = 254;
class << self
	attr_accessor :proc_scanner_en_block_comment
end
self.proc_scanner_en_block_comment = 256;
class << self
	attr_accessor :proc_scanner_en_heredoc
end
self.proc_scanner_en_heredoc = 258;
class << self
	attr_accessor :proc_scanner_en_string
end
self.proc_scanner_en_string = 260;
class << self
	attr_accessor :proc_scanner_en_dstring1
end
self.proc_scanner_en_dstring1 = 292;
class << self
	attr_accessor :proc_scanner_en_dstring2
end
self.proc_scanner_en_dstring2 = 293;
class << self
	attr_accessor :proc_scanner_en_dstring3
end
self.proc_scanner_en_dstring3 = 294;
class << self
	attr_accessor :proc_scanner_en_dstring4
end
self.proc_scanner_en_dstring4 = 295;
class << self
	attr_accessor :proc_scanner_en_dstring5
end
self.proc_scanner_en_dstring5 = 296;
class << self
	attr_accessor :proc_scanner_en_dstring6
end
self.proc_scanner_en_dstring6 = 297;
class << self
	attr_accessor :proc_scanner_en_dstring7
end
self.proc_scanner_en_dstring7 = 298;
class << self
	attr_accessor :proc_scanner_en_dstring8
end
self.proc_scanner_en_dstring8 = 299;
class << self
	attr_accessor :proc_scanner_en_dstring9
end
self.proc_scanner_en_dstring9 = 300;
class << self
	attr_accessor :proc_scanner_en_dstring10
end
self.proc_scanner_en_dstring10 = 301;
class << self
	attr_accessor :proc_scanner_en_dstring11
end
self.proc_scanner_en_dstring11 = 302;
class << self
	attr_accessor :proc_scanner_en_dstring12
end
self.proc_scanner_en_dstring12 = 303;
class << self
	attr_accessor :proc_scanner_en_dstring13
end
self.proc_scanner_en_dstring13 = 304;
class << self
	attr_accessor :proc_scanner_en_dstring14
end
self.proc_scanner_en_dstring14 = 305;
class << self
	attr_accessor :proc_scanner_en_dstring15
end
self.proc_scanner_en_dstring15 = 306;
class << self
	attr_accessor :proc_scanner_en_dstring16
end
self.proc_scanner_en_dstring16 = 307;
class << self
	attr_accessor :proc_scanner_en_dstring17
end
self.proc_scanner_en_dstring17 = 308;
class << self
	attr_accessor :proc_scanner_en_dstring18
end
self.proc_scanner_en_dstring18 = 309;
class << self
	attr_accessor :proc_scanner_en_dstring19
end
self.proc_scanner_en_dstring19 = 310;
class << self
	attr_accessor :proc_scanner_en_dstring20
end
self.proc_scanner_en_dstring20 = 311;
class << self
	attr_accessor :proc_scanner_en_dstring21
end
self.proc_scanner_en_dstring21 = 312;
class << self
	attr_accessor :proc_scanner_en_dstring22
end
self.proc_scanner_en_dstring22 = 313;
class << self
	attr_accessor :proc_scanner_en_dstring23
end
self.proc_scanner_en_dstring23 = 314;
class << self
	attr_accessor :proc_scanner_en_dstring24
end
self.proc_scanner_en_dstring24 = 315;
class << self
	attr_accessor :proc_scanner_en_dstring25
end
self.proc_scanner_en_dstring25 = 316;
class << self
	attr_accessor :proc_scanner_en_dstring26
end
self.proc_scanner_en_dstring26 = 317;
class << self
	attr_accessor :proc_scanner_en_dstring27
end
self.proc_scanner_en_dstring27 = 318;
class << self
	attr_accessor :proc_scanner_en_dstring28
end
self.proc_scanner_en_dstring28 = 319;
class << self
	attr_accessor :proc_scanner_en_main
end
self.proc_scanner_en_main = 224;


# line 460 "./spec/proc/../../lib/sourcify/proc/scanner.rl"

      extend Scanner::Extensions

      def self.execute!
        data = @data
        eof = data.length
        
# line 2 "./spec/proc/../../lib/sourcify/proc/scanner.rb"
begin
	p ||= 0
	pe ||= data.length
	cs = proc_scanner_start
	ts = nil
	te = nil
	act = 0
end

# line 467 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
        
# line 2 "./spec/proc/../../lib/sourcify/proc/scanner.rb"
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
# line 2 "./spec/proc/../../lib/sourcify/proc/scanner.rb"
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
	_trans = _proc_scanner_indicies[_trans]
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
# line 46 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      push(:kw_do_alias2, ts, te)
      increment_counter(:do_end, 0..1)
      	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

     end
		end
when 5 then
# line 55 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      push(:kw_do_alias1, ts, te)
      increment_counter(:do_end, 1)
      	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

     end
		end
when 6 then
# line 62 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin  p = p - 1; 	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end
  end
		end
when 7 then
# line 55 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p
p = p - 1; begin 
      push(:kw_do_alias1, ts, te)
      increment_counter(:do_end, 1)
      	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

     end
		end
when 8 then
# line 61 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p
p = p - 1; begin  push(:space, ts, te)  end
		end
when 9 then
# line 62 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p
p = p - 1; begin  p = p - 1; 	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end
  end
		end
when 10 then
# line 55 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
 begin p = ((te))-1; end
 begin 
      push(:kw_do_alias1, ts, te)
      increment_counter(:do_end, 1)
      	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

     end
		end
when 11 then
# line 62 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
 begin p = ((te))-1; end
 begin  p = p - 1; 	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end
  end
		end
when 12 then
# line 68 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
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
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

    end
end 
			end
when 14 then
# line 76 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
act = 6;		end
when 15 then
# line 76 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p
p = p - 1; begin 
      unless push_comment(ts, te)
        	begin
		cs = 224
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
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

      end
    end
end 
			end
when 17 then
# line 85 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p
p = p - 1; begin 
      unless push_heredoc(ts, te)
        	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

      end
     end
		end
when 18 then
# line 140 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
act = 10;		end
when 19 then
# line 169 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
act = 37;		end
when 20 then
# line 134 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      push(:sstring, ts, te)
     end
		end
when 21 then
# line 139 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin  push_dstring(ts, te); 	begin
		cs = 292
		_trigger_goto = true
		_goto_level = _again
		break
	end
  end
		end
when 22 then
# line 140 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin  push_dstring(ts, te); 	begin
		cs = 293
		_trigger_goto = true
		_goto_level = _again
		break
	end
  end
		end
when 23 then
# line 141 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin  push_dstring(ts, te); 	begin
		cs = 294
		_trigger_goto = true
		_goto_level = _again
		break
	end
  end
		end
when 24 then
# line 142 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin  push_dstring(ts, te); 	begin
		cs = 295
		_trigger_goto = true
		_goto_level = _again
		break
	end
  end
		end
when 25 then
# line 143 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin  push_dstring(ts, te); 	begin
		cs = 296
		_trigger_goto = true
		_goto_level = _again
		break
	end
  end
		end
when 26 then
# line 144 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin  push_dstring(ts, te); 	begin
		cs = 297
		_trigger_goto = true
		_goto_level = _again
		break
	end
  end
		end
when 27 then
# line 145 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin  push_dstring(ts, te); 	begin
		cs = 298
		_trigger_goto = true
		_goto_level = _again
		break
	end
  end
		end
when 28 then
# line 146 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin  push_dstring(ts, te); 	begin
		cs = 299
		_trigger_goto = true
		_goto_level = _again
		break
	end
  end
		end
when 29 then
# line 147 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin  push_dstring(ts, te); 	begin
		cs = 300
		_trigger_goto = true
		_goto_level = _again
		break
	end
  end
		end
when 30 then
# line 148 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin  push_dstring(ts, te); 	begin
		cs = 301
		_trigger_goto = true
		_goto_level = _again
		break
	end
  end
		end
when 31 then
# line 149 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin  push_dstring(ts, te); 	begin
		cs = 302
		_trigger_goto = true
		_goto_level = _again
		break
	end
  end
		end
when 32 then
# line 150 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin  push_dstring(ts, te); 	begin
		cs = 303
		_trigger_goto = true
		_goto_level = _again
		break
	end
  end
		end
when 33 then
# line 151 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin  push_dstring(ts, te); 	begin
		cs = 304
		_trigger_goto = true
		_goto_level = _again
		break
	end
  end
		end
when 34 then
# line 152 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin  push_dstring(ts, te); 	begin
		cs = 305
		_trigger_goto = true
		_goto_level = _again
		break
	end
  end
		end
when 35 then
# line 153 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin  push_dstring(ts, te); 	begin
		cs = 306
		_trigger_goto = true
		_goto_level = _again
		break
	end
  end
		end
when 36 then
# line 154 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin  push_dstring(ts, te); 	begin
		cs = 307
		_trigger_goto = true
		_goto_level = _again
		break
	end
  end
		end
when 37 then
# line 155 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin  push_dstring(ts, te); 	begin
		cs = 308
		_trigger_goto = true
		_goto_level = _again
		break
	end
  end
		end
when 38 then
# line 156 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin  push_dstring(ts, te); 	begin
		cs = 309
		_trigger_goto = true
		_goto_level = _again
		break
	end
  end
		end
when 39 then
# line 157 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin  push_dstring(ts, te); 	begin
		cs = 310
		_trigger_goto = true
		_goto_level = _again
		break
	end
  end
		end
when 40 then
# line 158 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin  push_dstring(ts, te); 	begin
		cs = 311
		_trigger_goto = true
		_goto_level = _again
		break
	end
  end
		end
when 41 then
# line 159 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin  push_dstring(ts, te); 	begin
		cs = 312
		_trigger_goto = true
		_goto_level = _again
		break
	end
  end
		end
when 42 then
# line 160 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin  push_dstring(ts, te); 	begin
		cs = 313
		_trigger_goto = true
		_goto_level = _again
		break
	end
  end
		end
when 43 then
# line 161 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin  push_dstring(ts, te); 	begin
		cs = 314
		_trigger_goto = true
		_goto_level = _again
		break
	end
  end
		end
when 44 then
# line 162 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin  push_dstring(ts, te); 	begin
		cs = 315
		_trigger_goto = true
		_goto_level = _again
		break
	end
  end
		end
when 45 then
# line 163 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin  push_dstring(ts, te); 	begin
		cs = 316
		_trigger_goto = true
		_goto_level = _again
		break
	end
  end
		end
when 46 then
# line 164 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin  push_dstring(ts, te); 	begin
		cs = 317
		_trigger_goto = true
		_goto_level = _again
		break
	end
  end
		end
when 47 then
# line 165 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin  push_dstring(ts, te); 	begin
		cs = 318
		_trigger_goto = true
		_goto_level = _again
		break
	end
  end
		end
when 48 then
# line 166 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin  push_dstring(ts, te); 	begin
		cs = 319
		_trigger_goto = true
		_goto_level = _again
		break
	end
  end
		end
when 49 then
# line 169 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      push(:any, ts, te)
      	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

     end
		end
when 50 then
# line 134 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p
p = p - 1; begin 
      push(:sstring, ts, te)
     end
		end
when 51 then
# line 140 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p
p = p - 1; begin  push_dstring(ts, te); 	begin
		cs = 293
		_trigger_goto = true
		_goto_level = _again
		break
	end
  end
		end
when 52 then
# line 169 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p
p = p - 1; begin 
      push(:any, ts, te)
      	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

     end
		end
when 53 then
# line 134 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
 begin p = ((te))-1; end
 begin 
      push(:sstring, ts, te)
     end
		end
when 54 then
# line 169 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
 begin p = ((te))-1; end
 begin 
      push(:any, ts, te)
      	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

     end
		end
when 55 then
# line 1 "NONE"
		begin
	case act
	when 10 then
	begin begin p = ((te))-1; end
 push_dstring(ts, te); 	begin
		cs = 293
		_trigger_goto = true
		_goto_level = _again
		break
	end
 end
	when 37 then
	begin begin p = ((te))-1; end

      push(:any, ts, te)
      	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

    end
end 
			end
when 56 then
# line 177 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      unless push_dstring(ts, te)
        	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

      end
     end
		end
when 57 then
# line 184 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      unless push_dstring(ts, te)
        	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

      end
     end
		end
when 58 then
# line 191 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      unless push_dstring(ts, te)
        	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

      end
     end
		end
when 59 then
# line 198 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      unless push_dstring(ts, te)
        	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

      end
     end
		end
when 60 then
# line 205 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      unless push_dstring(ts, te)
        	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

      end
     end
		end
when 61 then
# line 212 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      unless push_dstring(ts, te)
        	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

      end
     end
		end
when 62 then
# line 219 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      unless push_dstring(ts, te)
        	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

      end
     end
		end
when 63 then
# line 226 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      unless push_dstring(ts, te)
        	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

      end
     end
		end
when 64 then
# line 233 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      unless push_dstring(ts, te)
        	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

      end
     end
		end
when 65 then
# line 240 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      unless push_dstring(ts, te)
        	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

      end
     end
		end
when 66 then
# line 247 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      unless push_dstring(ts, te)
        	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

      end
     end
		end
when 67 then
# line 254 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      unless push_dstring(ts, te)
        	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

      end
     end
		end
when 68 then
# line 261 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      unless push_dstring(ts, te)
        	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

      end
     end
		end
when 69 then
# line 268 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      unless push_dstring(ts, te)
        	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

      end
     end
		end
when 70 then
# line 275 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      unless push_dstring(ts, te)
        	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

      end
     end
		end
when 71 then
# line 282 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      unless push_dstring(ts, te)
        	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

      end
     end
		end
when 72 then
# line 289 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      unless push_dstring(ts, te)
        	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

      end
     end
		end
when 73 then
# line 296 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      unless push_dstring(ts, te)
        	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

      end
     end
		end
when 74 then
# line 303 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      unless push_dstring(ts, te)
        	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

      end
     end
		end
when 75 then
# line 310 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      unless push_dstring(ts, te)
        	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

      end
     end
		end
when 76 then
# line 317 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      unless push_dstring(ts, te)
        	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

      end
     end
		end
when 77 then
# line 324 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      unless push_dstring(ts, te)
        	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

      end
     end
		end
when 78 then
# line 331 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      unless push_dstring(ts, te)
        	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

      end
     end
		end
when 79 then
# line 338 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      unless push_dstring(ts, te)
        	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

      end
     end
		end
when 80 then
# line 345 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      unless push_dstring(ts, te)
        	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

      end
     end
		end
when 81 then
# line 352 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      unless push_dstring(ts, te)
        	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

      end
     end
		end
when 82 then
# line 359 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      unless push_dstring(ts, te)
        	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

      end
     end
		end
when 83 then
# line 366 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      unless push_dstring(ts, te)
        	begin
		cs = 224
		_trigger_goto = true
		_goto_level = _again
		break
	end

      end
     end
		end
when 84 then
# line 378 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
act = 66;		end
when 85 then
# line 384 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
act = 67;		end
when 86 then
# line 419 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
act = 73;		end
when 87 then
# line 450 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
act = 78;		end
when 88 then
# line 391 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      push(:lbrace, ts, te)
      increment_counter(:brace)
     end
		end
when 89 then
# line 396 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      push(:rbrace, ts, te)
      decrement_counter(:brace)
     end
		end
when 90 then
# line 401 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      push(:assoc, ts, te)
      fix_counter_false_start(:brace)
     end
		end
when 91 then
# line 406 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      push_label(ts, te)
      fix_counter_false_start(:brace)
     end
		end
when 92 then
# line 419 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      push(:newline_alias, ts, te)
      	begin
		cs = 241
		_trigger_goto = true
		_goto_level = _again
		break
	end

     end
		end
when 93 then
# line 426 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      	begin
		cs = 254
		_trigger_goto = true
		_goto_level = _again
		break
	end

     end
		end
when 94 then
# line 430 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      push_comment(ts, te)
      increment_lineno
      	begin
		cs = 256
		_trigger_goto = true
		_goto_level = _again
		break
	end

     end
		end
when 95 then
# line 438 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      push_heredoc(ts, te)
      increment_lineno
      	begin
		cs = 258
		_trigger_goto = true
		_goto_level = _again
		break
	end

     end
		end
when 96 then
# line 444 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin 
      p = p - 1; 	begin
		cs = 260
		_trigger_goto = true
		_goto_level = _again
		break
	end

     end
		end
when 97 then
# line 454 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p+1
 begin  push(:any, ts, te)  end
		end
when 98 then
# line 406 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p
p = p - 1; begin 
      push_label(ts, te)
      fix_counter_false_start(:brace)
     end
		end
when 99 then
# line 413 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p
p = p - 1; begin 
      push(:newline, ts, te)
      increment_lineno
      	begin
		cs = 241
		_trigger_goto = true
		_goto_level = _again
		break
	end

     end
		end
when 100 then
# line 419 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p
p = p - 1; begin 
      push(:newline_alias, ts, te)
      	begin
		cs = 241
		_trigger_goto = true
		_goto_level = _again
		break
	end

     end
		end
when 101 then
# line 450 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p
p = p - 1; begin  push(:var, ts, te)  end
		end
when 102 then
# line 451 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p
p = p - 1; begin  push(:const, ts, te)  end
		end
when 103 then
# line 452 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p
p = p - 1; begin  push(:symbol, ts, te)  end
		end
when 104 then
# line 453 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p
p = p - 1; begin  push(:space, ts, te)  end
		end
when 105 then
# line 454 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
te = p
p = p - 1; begin  push(:any, ts, te)  end
		end
when 106 then
# line 406 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
 begin p = ((te))-1; end
 begin 
      push_label(ts, te)
      fix_counter_false_start(:brace)
     end
		end
when 107 then
# line 413 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
 begin p = ((te))-1; end
 begin 
      push(:newline, ts, te)
      increment_lineno
      	begin
		cs = 241
		_trigger_goto = true
		_goto_level = _again
		break
	end

     end
		end
when 108 then
# line 452 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
 begin p = ((te))-1; end
 begin  push(:symbol, ts, te)  end
		end
when 109 then
# line 454 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
		begin
 begin p = ((te))-1; end
 begin  push(:any, ts, te)  end
		end
when 110 then
# line 1 "NONE"
		begin
	case act
	when 66 then
	begin begin p = ((te))-1; end

      push(:kw_do, ts, te)
      increment_counter(:do_end)
      	begin
		cs = 241
		_trigger_goto = true
		_goto_level = _again
		break
	end

    end
	when 67 then
	begin begin p = ((te))-1; end

      push(:kw_end, ts, te)
      decrement_counter(:do_end)
    end
	when 73 then
	begin begin p = ((te))-1; end

      push(:newline_alias, ts, te)
      	begin
		cs = 241
		_trigger_goto = true
		_goto_level = _again
		break
	end

    end
	when 78 then
	begin begin p = ((te))-1; end
 push(:var, ts, te) end
end 
			end
# line 2 "./spec/proc/../../lib/sourcify/proc/scanner.rb"
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
# line 2 "./spec/proc/../../lib/sourcify/proc/scanner.rb"
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

# line 468 "./spec/proc/../../lib/sourcify/proc/scanner.rl"
      end

    end
  end
end
