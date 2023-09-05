"""
Transfer matrix for ZEUS experiment 
high-x data.

N = T K S
T = Transfer matrix (including data luminosity)
K - Radiative corrections
S = Born-level integrated sigma

Based on C++ code by R. Aggarwal.
"""

include("../../src/MetaData.jl")

export SysPenality, Init_sys
export Tnm_sys_ePp, Tnm_sys_eMp
export MD_ZEUS_I1787035
export get_pred_N
export get_data_events
export get_TM_elements
export get_K_elements
export get_bin_info

export q2bins_M_begin
export q2bins_M_end
export xbins_M_begin
export xbins_M_end


include("ePp_jl/SysTnm_Eehigh_ePp.jl")
include("ePp_jl/SysTnm_Eelow_ePp.jl")
include("ePp_jl/SysTnm_Eeconehigh_ePp.jl")
include("ePp_jl/SysTnm_Eeconelow_ePp.jl")
include("ePp_jl/SysTnm_Eereshigh_ePp.jl")
include("ePp_jl/SysTnm_Eereslow_ePp.jl")
include("ePp_jl/SysTnm_Ejhigh_ePp.jl")
include("ePp_jl/SysTnm_Ejlow_ePp.jl")
include("ePp_jl/SysTnm_FBcalhigh_ePp.jl")
include("ePp_jl/SysTnm_FBcallow_ePp.jl")
include("ePp_jl/SysTnm_FCALxhigh_ePp.jl")
include("ePp_jl/SysTnm_FCALxlow_ePp.jl")
include("ePp_jl/SysTnm_FCALyhigh_ePp.jl")
include("ePp_jl/SysTnm_FCALylow_ePp.jl")
include("ePp_jl/SysTnm_AriMepsUp_ePp.jl")
include("ePp_jl/SysTnm_AriMepsDown_ePp.jl")

include("eMp_jl/SysTnm_Eehigh_eMp.jl")
include("eMp_jl/SysTnm_Eelow_eMp.jl")
include("eMp_jl/SysTnm_Eeconehigh_eMp.jl")
include("eMp_jl/SysTnm_Eeconelow_eMp.jl")
include("eMp_jl/SysTnm_Eereshigh_eMp.jl")
include("eMp_jl/SysTnm_Eereslow_eMp.jl")
include("eMp_jl/SysTnm_Ejhigh_eMp.jl")
include("eMp_jl/SysTnm_Ejlow_eMp.jl")
include("eMp_jl/SysTnm_FBcalhigh_eMp.jl")
include("eMp_jl/SysTnm_FBcallow_eMp.jl")
include("eMp_jl/SysTnm_FCALxhigh_eMp.jl")
include("eMp_jl/SysTnm_FCALxlow_eMp.jl")
include("eMp_jl/SysTnm_FCALyhigh_eMp.jl")
include("eMp_jl/SysTnm_FCALylow_eMp.jl")
include("eMp_jl/SysTnm_AriMepsUp_eMp.jl")
include("eMp_jl/SysTnm_AriMepsDown_eMp.jl")
include("zeus_transfer_matrix.jl")

const NP1 = size(Tnm_Eehigh_ePp, 1)
const NP2 = size(Tnm_Eehigh_ePp, 2)
const nsyst = 8
# NP1 429
# NP2 153
# nsyst 8

const Tnm_sys_ePp = zeros(NP1, NP2, nsyst)
const Tnm_sys_eMp = zeros(NP1, NP2, nsyst)


const MD_ZEUS_I1787035 = MetaData("ZEUS_I1787035", 141.44, 185.018, 318.0);

const MD_G = MD_ZEUS_I1787035

const Kii_ePp = [1.075350,  1.003320,  1.000400,  0.990515,  0.982716,  0.991055,  0.988341,  0.981917,  0.980651,  0.986780,  0.978161,  0.979811,  0.982016,  0.978710,  0.983782,  0.971057,  0.978488,  0.975920,  0.988415,  0.979094,  0.982706,  0.967480,  0.976363,  0.962926,  0.956451,  0.970436,  0.972125,  0.971435,  0.978143,  0.980123,  0.978602,  0.979430,  0.981199,  0.964993,  0.968610,  0.977644,  0.965275,  0.986946,  0.972367,  0.958202,  0.975699,  0.955904,  0.972181,  0.971894,  0.947383,  0.973797,  0.971908,  0.967475,  0.994818,  1.002060,  0.966302,  0.984167,  1.012470,  0.987927,  0.969459,  0.971634,  0.943331,  1.036480,  1.007000,  0.959540,  0.951941,  0.949486,  0.959048,  0.941804,  0.933821,  0.945555,  0.940606,  0.922172,  0.937647,  0.940727,  0.941533,  0.951882,  0.941085,  0.932116,  0.912904,  0.931410,  0.945248,  0.929356,  0.926937,  0.927833,  0.918422,  0.932223,  0.934433,  0.947782,  0.936372,  0.945039,  0.938996,  0.905350,  0.919948,  0.921932,  0.938847,  0.935186,  0.938086,  0.930847,  0.928879,  0.956267,  0.960114,  0.999759,  0.900377,  0.926618,  0.932317,  0.929905,  0.912250,  1.031460,  0.969866,  0.956479,  0.938385,  0.935139,  0.922997,  0.927485,  0.940471,  0.905135,  0.942297,  0.934708,  0.920107,  0.912008,  0.921937,  0.947627,  0.927544,  0.936009,  0.912867,  0.928573,  0.926293,  0.923377,  0.929465,  0.938540,  0.923919,  0.921980,  0.913181,  0.924672,  0.913502,  0.936423,  0.935221,  0.907557,  0.921723,  0.919313,  0.916578,  0.944285,  0.922282,  0.942937,  0.956420,  0.912373,  0.874804,  1.030950,  1.014740,  0.958397,  0.940582,  0.922322,  0.934183,  0.939193,  0.915529,  0.923484,  0.925398,  0.914873,  0.951898,  0.878644,  0.914004,  0.917130,  0.913206,  0.915045,  0.938590,  0.920165,  0.922084,  0.933941,  0.921054,  0.913637,  0.920899,  0.886364,  0.939337,  0.925387,  0.908335,  0.906015,  0.946130,  0.935466,  0.897503,  0.909042,  0.903089,  0.915610,  0.946036,  0.906481,  0.907504,  0.941501,  1.000390,  0.954487,  0.936486,  0.927232,  0.930549,  0.947041,  0.935678,  0.919745,  0.934273,  0.914281,  0.932723,  0.916074,  0.925046,  0.921074,  0.884773,  0.915894,  0.912260,  0.912166,  0.924341,  0.884810,  0.905170,  0.945883,  0.911802,  0.928506,  0.985880,  0.928020,  0.923674,  0.934383,  0.923267,  0.932593,  0.944977,  0.899000,  0.884949,  1.032090,  1.015770,  0.949491,  0.941821,  0.935690,  0.931891,  0.940713,  0.936111,  0.923026,  0.926895,  0.929353,  0.917705,  0.923760,  0.920243,  0.928389,  0.908535,  0.889085,  0.901931,  0.923028,  0.915331,  0.908819,  0.905061,  0.929963,  0.907731,  0.920211,  0.917110,  0.938830,  0.894957,  0.894372,  0.890258,  0.909116,  0.917673,  0.915678,  0.921762,  0.911600,  1.020460,  0.975796,  0.947976,  0.934351,  0.935352,  0.925090,  0.912195,  0.908894,  0.915240,  0.920323,  0.907459,  0.916079,  0.928365,  0.919338,  0.933231,  0.906059,  0.916785,  0.909470,  0.917859,  0.900160,  0.893100,  0.914287,  0.909324,  0.907140,  0.918068,  0.898798,  0.919127,  0.915144,  0.920465,  0.952497,  0.897620,  1.021370,  0.972526,  0.931079,  0.927369,  0.921518,  0.925361,  0.911551,  0.926449,  0.922647,  0.905223,  0.897426,  0.906410,  0.905802,  0.913580,  0.881542,  0.904748,  0.907336,  0.914081,  0.904564,  1.014390,  0.966775,  0.929271,  0.905580,  0.923660,  0.924995,  0.930181,  0.922937,  0.899282,  0.912241,  0.917199,  0.914518,  0.892989,  0.907300,  0.914064,  0.901526,  0.891592,  0.995305,  0.967957,  0.954505,  0.939866,  0.917194,  0.924797,  0.938293,  0.911567,  0.927405,  0.892165,  0.915668,  0.920527,  0.904715,  0.893306,  0.904545,  0.924339,  0.892634,  0.936641,  0.883983,  0.973065,  0.972751,  0.937119,  0.943007,  0.914105,  0.909482,  0.897116,  0.927891,  0.893963,  0.923131,  0.897742,  0.900238,  0.888815,  0.907836,  0.887370,  0.906790,  0.942582,  0.983738,  0.955781,  0.924748,  0.908299,  0.918437,  0.901987,  0.908967,  0.886840,  0.906445,  0.904899,  0.885595,  0.887780,  0.915325,  0.897321,  0.931359,  0.865367,  0.865087,  0.987319,  0.932197,  0.902079,  0.887348,  0.917391,  0.900288,  0.906144,  0.886011,  0.881684,  0.933251,  0.889883,  0.928064,  0.893343,  0.888162,  1.018380,  0.954751,  0.917015,  0.909286,  0.911324,  0.886562,  0.905869,  0.878072,  0.903504,  0.904388,  0.923037,  0.944003,  0.889721,  0.847906,  0.868747,  0.970846,  0.915454,  0.898777,  0.901173,  0.879986,  0.894341,  0.898215,  0.860089,  0.873740,  0.929175,  0.885283,  0.899485,  0.918820,  0.923964,  0.898271,  0.899609,  0.913215,  0.869430,  0.889515,  0.889669,  0.857518,  0.837175,  0.875777,  0.897924,  0.935441,  0.933215,  0.899119,  0.910332,  1.125100,  1.120070 ]
const Kii_eMp = [1.075590,  1.004940,  0.997145,  0.994087,  0.991775,  0.990224,  0.983910,  0.991145,  0.993283,  0.976963,  0.982326,  0.975760,  0.981003,  0.975962,  0.981898,  0.977687,  0.974887,  0.971409,  0.978575,  0.966611,  0.979775,  0.961380,  0.974330,  0.975769,  0.972812,  0.980839,  0.979556,  0.969807,  0.978863,  0.975166,  0.975178,  0.974558,  0.976924,  0.970897,  0.967817,  0.964012,  0.977105,  0.975387,  0.969293,  0.978287,  0.965644,  0.968173,  0.979812,  0.971859,  0.958693,  0.967514,  0.968905,  0.983296,  0.994280,  0.988457,  0.990996,  0.967560,  0.981393,  0.978275,  0.987860,  0.930696,  0.990174,  1.087660,  1.008470,  0.950922,  0.953512,  0.941160,  0.959252,  0.930738,  0.936608,  0.941744,  0.947568,  0.941424,  0.938006,  0.941990,  0.918409,  0.934451,  0.929498,  0.925344,  0.930891,  0.935225,  0.930747,  0.931903,  0.932481,  0.932620,  0.926521,  0.930687,  0.928137,  0.925623,  0.913815,  0.920704,  0.903114,  0.916453,  0.920398,  0.932719,  0.915654,  0.920361,  0.908663,  0.918288,  0.924349,  0.947861,  0.963312,  0.955298,  0.944497,  0.936036,  0.958065,  0.961611,  0.924317,  1.022710,  0.968362,  0.946961,  0.934998,  0.930893,  0.938067,  0.928906,  0.938595,  0.937935,  0.941209,  0.921380,  0.905577,  0.935549,  0.924691,  0.959134,  0.917296,  0.926542,  0.921188,  0.915554,  0.907316,  0.928998,  0.909081,  0.928038,  0.913148,  0.918110,  0.931674,  0.918781,  0.926644,  0.898171,  0.921739,  0.915680,  0.926974,  0.908487,  0.935809,  0.908011,  0.936179,  0.939054,  0.920547,  0.912484,  0.905784,  1.047240,  1.013940,  0.959236,  0.950538,  0.937970,  0.933247,  0.929729,  0.935752,  0.917188,  0.929946,  0.950805,  0.918368,  0.934240,  0.939967,  0.919068,  0.929262,  0.925247,  0.926150,  0.911975,  0.908020,  0.919989,  0.904316,  0.915883,  0.925796,  0.911573,  0.952684,  0.927411,  0.936359,  0.897089,  0.938295,  0.917212,  0.917263,  0.880603,  0.895000,  0.960681,  0.920057,  0.921983,  0.937336,  0.920891,  0.989904,  0.945097,  0.936499,  0.933008,  0.923058,  0.925836,  0.916512,  0.918853,  0.911456,  0.919157,  0.917528,  0.924824,  0.917210,  0.915404,  0.920101,  0.917518,  0.917331,  0.937515,  0.908025,  0.913851,  0.885663,  0.910633,  0.920910,  0.902236,  0.883985,  0.936215,  0.892376,  0.924161,  0.912710,  0.920910,  0.927704,  0.940881,  0.911837,  1.036420,  0.990419,  0.964860,  0.942533,  0.940186,  0.925944,  0.927079,  0.917892,  0.929939,  0.917089,  0.924414,  0.919441,  0.914140,  0.922384,  0.922879,  0.910491,  0.927328,  0.922025,  0.907635,  0.909444,  0.915501,  0.911481,  0.922555,  0.902034,  0.884763,  0.896033,  0.922548,  0.909479,  0.902007,  0.909202,  0.894980,  0.908599,  0.913233,  0.931017,  0.903586,  1.032380,  0.966915,  0.939360,  0.935257,  0.920633,  0.919506,  0.918396,  0.923125,  0.909852,  0.917011,  0.913592,  0.907291,  0.916185,  0.903920,  0.898359,  0.889976,  0.890971,  0.916794,  0.908540,  0.898337,  0.908663,  0.897588,  0.908182,  0.931282,  0.896395,  0.905401,  0.911750,  0.903489,  0.912152,  0.911475,  0.926070,  0.991237,  0.959946,  0.937582,  0.940928,  0.922576,  0.918635,  0.914345,  0.926886,  0.921085,  0.897296,  0.923636,  0.904686,  0.907247,  0.902663,  0.899677,  0.897653,  0.899738,  0.910009,  0.901818,  0.996988,  0.955733,  0.934113,  0.933095,  0.914492,  0.924760,  0.916160,  0.894471,  0.902779,  0.910106,  0.901284,  0.891679,  0.888937,  0.902271,  0.919112,  0.919921,  0.913008,  0.989923,  0.962648,  0.943908,  0.920121,  0.916313,  0.922150,  0.915115,  0.921470,  0.919170,  0.909989,  0.896874,  0.894431,  0.913555,  0.893403,  0.897901,  0.914834,  0.912072,  0.922758,  0.910984,  0.999433,  0.972097,  0.937046,  0.930701,  0.920699,  0.908517,  0.921110,  0.898016,  0.898074,  0.902121,  0.902813,  0.910567,  0.891661,  0.906273,  0.921884,  0.927759,  0.931392,  0.965891,  0.924119,  0.920754,  0.938121,  0.899295,  0.913039,  0.893495,  0.881225,  0.892974,  0.903447,  0.895149,  0.901726,  0.895471,  0.879280,  0.933071,  0.886006,  0.892536,  0.988053,  0.934415,  0.909182,  0.892721,  0.897238,  0.897666,  0.892575,  0.872965,  0.894868,  0.890439,  0.901489,  0.866784,  0.878905,  0.866257,  1.037540,  0.956781,  0.919218,  0.898951,  0.882910,  0.896701,  0.907357,  0.882179,  0.907828,  0.890074,  0.879357,  0.861196,  0.893743,  0.868536,  0.897948,  0.954828,  0.924134,  0.910290,  0.884310,  0.885500,  0.880802,  0.901093,  0.887510,  0.883695,  0.902523,  0.927851,  0.880994,  0.889341,  0.923642,  0.911657,  0.896790,  0.869225,  0.882357,  0.862142,  0.886623,  0.897826,  0.889232,  0.890147,  0.892718,  0.883950,  0.921764,  0.882477,  0.891006,  0.911363,  0.877797 ]
const Data_Events_eMp = [ 743,    580,    441,    416,    283,    248,    227,    504,    789,    681,    604,    493,    403,    385,    271,    258,    671,    598,    489,    450,    402,    342,    231,    224,    363,    414,    552,    454,    412,    430,    326,    272,    209,    310,    368,    358,    308,    317,    300,    206,    183,    139,    231,    202,    419,    358,    351,    298,    276,    254,    195,    158,    227,    173,    265,    251,    214,    228,    172,    124,    157,     86,    138,     74,    214,    187,    153,    159,    132,    117,     75,     72,     48,     76,     51,    168,    142,    160,    119,    122,    111,     74,     37,     67,     36,    104,    106,     77,     82,     68,     58,     65,     26,     32,     19,    151,    117,     90,     84,     76,     48,     34,     23,     33,     17,     90,     98,    103,     69,     60,     47,     31,     24,     14,     18,      5,    114,    117,    117,     91,     92,     52,     42,     14,     21,     14,      5,      3,     93,     89,     68,     56,     49,     41,     23,     17,      8,      4,     10,      1,     76,     53,     40,     27,     19,     12,      8,      5,      4,      1,      1,    120,      8]
const Data_Events_ePp = [ 567,    418,    321,    274,    207,    176,    152,    371,    599,    497,    407,    351,    288,    291,    199,    185,    482,    433,    344,    314,    275,    255,    184,    190,    284,    281,    377,    314,    285,    325,    213,    210,    143,    219,    275,    262,    230,    206,    197,    153,    148,    107,    180,    146,    288,    281,    244,    223,    225,    202,    147,    119,    167,    115,    180,    161,    161,    146,    117,     94,     79,     65,     85,     62,    135,    122,    114,    134,     81,     83,     51,     66,     30,     53,     31,    110,    111,    110,     87,     65,     71,     41,     36,     47,     27,     75,     99,     79,     61,     48,     46,     30,     13,     14,     13,    100,     63,     78,     45,     42,     29,     26,     21,     24,     11,     55,     54,     67,     53,     34,     21,     23,     16,      9,     12,      6,     60,     74,     60,     50,     66,     36,     33,     13,     13,     12,     13,      3,     45,     34,     40,     37,     28,     27,     13,      5,     10,      6,      1,      0,     19,     24,     23,     15,     14,      9,      8,      7,      2,      0,      0,     41,      3]


const BinQ2low = [650,   650,   650,   650,   650,   650,   650,   650,   800,   800,   800,   800,   800,   800,   800,   800,   800,   950,   950,   950,   950,   950,   950,   950,   950,   950,   1100,   1100,   1100,   1100,   1100,   1100,   1100,   1100,   1100,   1300,   1300,   1300,   1300,   1300,   1300,   1300,   1300,   1300,   1500,   1500,   1500,   1500,   1500,   1500,   1500,   1500,   1500,   1500,   1800,   1800,   1800,   1800,   1800,   1800,   1800,   1800,   1800,   1800,   2100,   2100,   2100,   2100,   2100,   2100,   2100,   2100,   2100,   2100,   2100,   2400,   2400,   2400,   2400,   2400,   2400,   2400,   2400,   2400,   2400,   2800,   2800,   2800,   2800,   2800,   2800,   2800,   2800,   2800,   2800,   3200,   3200,   3200,   3200,   3200,   3200,   3200,   3200,   3200,   3200,   3800,   3800,   3800,   3800,   3800,   3800,   3800,   3800,   3800,   3800,   3800,   4500,   4500,   4500,   4500,   4500,   4500,   4500,   4500,   4500,   4500,   4500,   4500,   6000,   6000,   6000,   6000,   6000,   6000,   6000,   6000,   6000,   6000,   6000,   6000,   8000,   8000,   8000,   8000,   8000,   8000,   8000,   8000,   8000,   8000,   8000,   11000,   11000]
const BinQ2high = [800,   800,   800,   800,   800,   800,   800,   800,   950,   950,   950,   950,   950,   950,   950,   950,   950,   1100,   1100,   1100,   1100,   1100,   1100,   1100,   1100,   1100,   1300,   1300,   1300,   1300,   1300,   1300,   1300,   1300,   1300,   1500,   1500,   1500,   1500,   1500,   1500,   1500,   1500,   1500,   1800,   1800,   1800,   1800,   1800,   1800,   1800,   1800,   1800,   1800,   2100,   2100,   2100,   2100,   2100,   2100,   2100,   2100,   2100,   2100,   2400,   2400,   2400,   2400,   2400,   2400,   2400,   2400,   2400,   2400,   2400,   2800,   2800,   2800,   2800,   2800,   2800,   2800,   2800,   2800,   2800,   3200,   3200,   3200,   3200,   3200,   3200,   3200,   3200,   3200,   3200,   3800,   3800,   3800,   3800,   3800,   3800,   3800,   3800,   3800,   3800,   4500,   4500,   4500,   4500,   4500,   4500,   4500,   4500,   4500,   4500,   4500,   6000,   6000,   6000,   6000,   6000,   6000,   6000,   6000,   6000,   6000,   6000,   6000,   8000,   8000,   8000,   8000,   8000,   8000,   8000,   8000,   8000,   8000,   8000,   8000,   11000,   11000,   11000,   11000,   11000,   11000,   11000,   11000,   11000,   11000,   11000,   20000,   20000 ]
const Binxlow=[0.054,   0.07,   0.088,   0.11,   0.14,   0.17,   0.21,   0.26,   0.044,   0.059,   0.076,   0.096,   0.12,   0.15,   0.19,   0.23,   0.28,   0.044,   0.059,   0.076,   0.096,   0.12,   0.15,   0.18,   0.22,   0.32,   0.048,   0.063,   0.08,   0.1,   0.13,   0.16,   0.2,   0.24,   0.34,   0.054,   0.07,   0.088,   0.11,   0.14,   0.17,   0.21,   0.25,   0.36,   0.044,   0.059,   0.076,   0.096,   0.12,   0.15,   0.19,   0.23,   0.28,   0.39,   0.054,   0.07,   0.088,   0.11,   0.14,   0.17,   0.21,   0.26,   0.31,   0.43,   0.048,   0.063,   0.08,   0.1,   0.13,   0.16,   0.2,   0.24,   0.29,   0.34,   0.46,   0.076,   0.096,   0.12,   0.15,   0.18,   0.22,   0.27,   0.32,   0.38,   0.5,   0.088,   0.11,   0.14,   0.17,   0.21,   0.25,   0.3,   0.36,   0.42,   0.54,   0.1,   0.13,   0.16,   0.2,   0.24,   0.29,   0.34,   0.4,   0.46,   0.58,   0.096,   0.12,   0.15,   0.19,   0.23,   0.28,   0.33,   0.39,   0.45,   0.51,   0.63,   0.096,   0.12,   0.15,   0.18,   0.22,   0.27,   0.32,   0.38,   0.44,   0.5,   0.56,   0.69,   0.1,   0.13,   0.16,   0.2,   0.24,   0.29,   0.35,   0.41,   0.47,   0.53,   0.59,   0.73,   0.15,   0.19,   0.23,   0.28,   0.33,   0.39,   0.45,   0.51,   0.57,   0.64,   0.78,   0.256,   0.6]
const Binxhigh=[0.07,   0.088,   0.11,   0.14,   0.17,   0.21,   0.26,   1,   0.059,   0.076,   0.096,   0.12,   0.15,   0.19,   0.23,   0.28,   1,   0.059,   0.076,   0.096,   0.12,   0.15,   0.18,   0.22,   0.32,   1,   0.063,   0.08,   0.1,   0.13,   0.16,   0.2,   0.24,   0.34,   1,   0.07,   0.088,   0.11,   0.14,   0.17,   0.21,   0.25,   0.36,   1,   0.059,   0.076,   0.096,   0.12,   0.15,   0.19,   0.23,   0.28,   0.39,   1,   0.07,   0.088,   0.11,   0.14,   0.17,   0.21,   0.26,   0.31,   0.43,   1,   0.063,   0.08,   0.1,   0.13,   0.16,   0.2,   0.24,   0.29,   0.34,   0.46,   1,   0.096,   0.12,   0.15,   0.18,   0.22,   0.27,   0.32,   0.38,   0.5,   1,   0.11,   0.14,   0.17,   0.21,   0.25,   0.3,   0.36,   0.42,   0.54,   1,   0.13,   0.16,   0.2,   0.24,   0.29,   0.34,   0.4,   0.46,   0.58,   1,   0.12,   0.15,   0.19,   0.23,   0.28,   0.33,   0.39,   0.45,   0.51,   0.63,   1,   0.12,   0.15,   0.18,   0.22,   0.27,   0.32,   0.38,   0.44,   0.5,   0.56,   0.69,   1,   0.13,   0.16,   0.2,   0.24,   0.29,   0.35,   0.41,   0.47,   0.53,   0.59,   0.73,   1,   0.19,   0.23,   0.28,   0.33,   0.39,   0.45,   0.51,   0.57,   0.64,   0.78,   1,   0.6,   1]






function get_data_events(eMPp)
    if eMPp == 0
        return Data_Events_ePp
    else
        return Data_Events_eMp
    end
end

function get_K_elements(eMPp)
    if eMPp == 0
        return Kii_ePp
    else
        return Kii_eMp
    end
end

function get_TM_elements(eMPp,md::MetaData)
    
    if eMPp == 1
        TM_elements = copy(TM_Elements_eMp)
        lumi_data = md.Ld_eMp    
    elseif eMPp == 0
        TM_elements = copy(TM_Elements_ePp)
        lumi_data = md.Ld_ePp
    end
    
    for i in 1:429
        for j in 1:153
         TM_elements[i,j] = TM_elements[i,j] * lumi_data
        end
    end
    
    return TM_elements
end

function get_pred_N(Integ_xsec, eMPp, md::MetaData)

    TM = get_TM_elements(eMPp, md);
    K = get_K_elements(eMPp)

    xsec_pred = zeros(153)
    for j in 1:153
        temp=0.
        for i in 1:429

        temp = temp +(TM[i,j]./K[i]) * Integ_xsec[i];
        end
        xsec_pred[j] = temp
    end
    return xsec_pred;
end

"""
    get_bin_info(n, quiet)

Get the bin egdes of the ZEUS 
detector space for a given 
bin number, `n`.
"""
function get_bin_info(n::Integer; quiet::Bool = false)

    if n < 1 || n > 153
        @error "Bin number n should be [1, 153]"
    end
    if !quiet
        @info "ZEUS detector bin" n BinQ2low[n] BinQ2high[n] Binxlow[n] Binxhigh[n]
    end
    return ([BinQ2low[n], BinQ2high[n]], [Binxlow[n], Binxhigh[n]])
end


const q2bins_M_begin = Float64.([400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 4500, 4500, 4500, 4500, 4500, 4500, 4500, 4500, 4500, 4500, 4500, 4500, 4500, 4500, 4500, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 11000, 11000, 11000, 20000, 20000]);

const q2bins_M_end = Float64.([650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 4500, 4500, 4500, 4500, 4500, 4500, 4500, 4500, 4500, 4500, 4500, 4500, 4500, 4500, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 11000, 11000, 11000, 11000, 11000, 11000, 11000, 11000, 11000, 11000, 11000, 11000, 20000, 20000, 20000, 30000, 30000]);

const xbins_M_begin = Float64.([0.0035, 0.007, 0.01, 0.012, 0.015, 0.017, 0.019, 0.022, 0.024, 0.026, 0.028, 0.03, 0.032, 0.034, 0.036, 0.038, 0.041, 0.044, 0.047, 0.05, 0.054, 0.059, 0.062, 0.065, 0.0675, 0.07, 0.073, 0.076, 0.079, 0.082, 0.085, 0.09, 0.096, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19, 0.2, 0.21, 0.22, 0.24, 0.26, 0.28, 0.3, 0.35, 0.4, 0.42, 0.435, 0.45, 0.5, 0.6, 0.7, 0.0035, 0.007, 0.01, 0.012, 0.015, 0.017, 0.019, 0.022, 0.024, 0.026, 0.028, 0.03, 0.032, 0.034, 0.036, 0.038, 0.041, 0.044, 0.046, 0.05, 0.054, 0.06, 0.07, 0.079, 0.088, 0.098, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.21, 0.23, 0.26, 0.28, 0.31, 0.35, 0.4, 0.42, 0.435, 0.45, 0.5, 0.6, 0.007, 0.01, 0.012, 0.015, 0.018, 0.022, 0.024, 0.026, 0.028, 0.03, 0.032, 0.034, 0.036, 0.038, 0.041, 0.044, 0.046, 0.05, 0.059, 0.067, 0.076, 0.085, 0.096, 0.11, 0.12, 0.13, 0.14, 0.15, 0.17, 0.19, 0.21, 0.23, 0.25, 0.28, 0.31, 0.35, 0.4, 0.425, 0.45, 0.55, 0.007, 0.01, 0.012, 0.015, 0.018, 0.022, 0.024, 0.026, 0.028, 0.03, 0.032, 0.034, 0.036, 0.038, 0.044, 0.05, 0.059, 0.067, 0.076, 0.085, 0.096, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19, 0.205, 0.22, 0.24, 0.26, 0.28, 0.3, 0.34, 0.4, 0.5, 0.01, 0.015, 0.018, 0.021, 0.024, 0.029, 0.033, 0.038, 0.042, 0.048, 0.056, 0.063, 0.072, 0.08, 0.09, 0.1, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19, 0.2, 0.22, 0.24, 0.27, 0.3, 0.34, 0.4, 0.5, 0.01, 0.015, 0.017, 0.019, 0.022, 0.026, 0.03, 0.034, 0.038, 0.042, 0.048, 0.054, 0.062, 0.07, 0.078, 0.088, 0.1, 0.105, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19, 0.2, 0.21, 0.22, 0.23, 0.25, 0.3, 0.36, 0.5, 0.01, 0.018, 0.022, 0.025, 0.028, 0.032, 0.038, 0.044, 0.05, 0.059, 0.066, 0.076, 0.086, 0.096, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19, 0.21, 0.23, 0.25, 0.28, 0.31, 0.34, 0.39, 0.45, 0.01, 0.022, 0.025, 0.028, 0.032, 0.038, 0.044, 0.054, 0.06, 0.07, 0.078, 0.088, 0.11, 0.14, 0.17, 0.21, 0.26, 0.31, 0.43, 0.01, 0.025, 0.029, 0.033, 0.039, 0.048, 0.058, 0.063, 0.08, 0.1, 0.13, 0.16, 0.2, 0.24, 0.29, 0.34, 0.46, 0.025, 0.028, 0.032, 0.038, 0.044, 0.05, 0.058, 0.065, 0.076, 0.086, 0.096, 0.12, 0.15, 0.18, 0.22, 0.27, 0.32, 0.38, 0.5, 0.025, 0.032, 0.038, 0.044, 0.05, 0.062, 0.072, 0.088, 0.11, 0.14, 0.17, 0.21, 0.25, 0.3, 0.36, 0.42, 0.54, 0.035, 0.042, 0.05, 0.06, 0.07, 0.085, 0.1, 0.115, 0.13, 0.16, 0.2, 0.24, 0.29, 0.34, 0.4, 0.46, 0.58, 0.035, 0.05, 0.07, 0.096, 0.12, 0.15, 0.19, 0.23, 0.28, 0.33, 0.39, 0.45, 0.51, 0.63, 0.035, 0.05, 0.07, 0.096, 0.12, 0.15, 0.18, 0.22, 0.27, 0.32, 0.38, 0.44, 0.5, 0.56, 0.69, 0.065, 0.1, 0.13, 0.16, 0.2, 0.24, 0.29, 0.35, 0.41, 0.47, 0.53, 0.59, 0.73, 0.105, 0.15, 0.19, 0.23, 0.28, 0.33, 0.39, 0.45, 0.51, 0.57, 0.64, 0.78, 0.13, 0.256, 0.6, 0.25, 0.6]);

const xbins_M_end = Float64.([0.007, 0.01, 0.012, 0.015, 0.017, 0.019, 0.022, 0.024, 0.026, 0.028, 0.03, 0.032, 0.034, 0.036, 0.038, 0.041, 0.044, 0.047, 0.05, 0.054, 0.059, 0.062, 0.065, 0.0675, 0.07, 0.073, 0.076, 0.079, 0.082, 0.085, 0.09, 0.096, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19, 0.2, 0.21, 0.22, 0.24, 0.26, 0.28, 0.3, 0.35, 0.4, 0.42, 0.435, 0.45, 0.5, 0.6, 0.7, 0.999999, 0.007, 0.01, 0.012, 0.015, 0.017, 0.019, 0.022, 0.024, 0.026, 0.028, 0.03, 0.032, 0.034, 0.036, 0.038, 0.041, 0.044, 0.046, 0.05, 0.054, 0.06, 0.07, 0.079, 0.088, 0.098, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.21, 0.23, 0.26, 0.28, 0.31, 0.35, 0.4, 0.42, 0.435, 0.45, 0.5, 0.6, 0.999999, 0.01, 0.012, 0.015, 0.018, 0.022, 0.024, 0.026, 0.028, 0.03, 0.032, 0.034, 0.036, 0.038, 0.041, 0.044, 0.046, 0.05, 0.059, 0.067, 0.076, 0.085, 0.096, 0.11, 0.12, 0.13, 0.14, 0.15, 0.17, 0.19, 0.21, 0.23, 0.25, 0.28, 0.31, 0.35, 0.4, 0.425, 0.45, 0.55, 0.99999, 0.01, 0.012, 0.015, 0.018, 0.022, 0.024, 0.026, 0.028, 0.03, 0.032, 0.034, 0.036, 0.038, 0.044, 0.05, 0.059, 0.067, 0.076, 0.085, 0.096, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19, 0.205, 0.22, 0.24, 0.26, 0.28, 0.3, 0.34, 0.4, 0.5, 0.999999, 0.015, 0.018, 0.021, 0.024, 0.029, 0.033, 0.038, 0.042, 0.048, 0.056, 0.063, 0.072, 0.08, 0.09, 0.1, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19, 0.2, 0.22, 0.24, 0.27, 0.3, 0.34, 0.4, 0.5, 0.999999, 0.015, 0.017, 0.019, 0.022, 0.026, 0.03, 0.034, 0.038, 0.042, 0.048, 0.054, 0.062, 0.07, 0.078, 0.088, 0.1, 0.105, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19, 0.2, 0.21, 0.22, 0.23, 0.25, 0.3, 0.36, 0.5, 0.999999, 0.018, 0.022, 0.025, 0.028, 0.032, 0.038, 0.044, 0.05, 0.059, 0.066, 0.076, 0.086, 0.096, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19, 0.21, 0.23, 0.25, 0.28, 0.31, 0.34, 0.39, 0.45, 0.999999, 0.022, 0.025, 0.028, 0.032, 0.038, 0.044, 0.054, 0.06, 0.07, 0.078, 0.088, 0.11, 0.14, 0.17, 0.21, 0.26, 0.31, 0.43, 0.999999, 0.025, 0.029, 0.033, 0.039, 0.048, 0.058, 0.063, 0.08, 0.1, 0.13, 0.16, 0.2, 0.24, 0.29, 0.34, 0.46, 0.999999, 0.028, 0.032, 0.038, 0.044, 0.05, 0.058, 0.065, 0.076, 0.086, 0.096, 0.12, 0.15, 0.18, 0.22, 0.27, 0.32, 0.38, 0.5, 0.999999, 0.032, 0.038, 0.044, 0.05, 0.062, 0.072, 0.088, 0.11, 0.14, 0.17, 0.21, 0.25, 0.3, 0.36, 0.42, 0.54, 0.999999, 0.042, 0.05, 0.06, 0.07, 0.085, 0.1, 0.115, 0.13, 0.16, 0.2, 0.24, 0.29, 0.34, 0.4, 0.46, 0.58, 0.999999, 0.05, 0.07, 0.096, 0.12, 0.15, 0.19, 0.23, 0.28, 0.33, 0.39, 0.45, 0.51, 0.63, 0.999999, 0.05, 0.07, 0.096, 0.12, 0.15, 0.18, 0.22, 0.27, 0.32, 0.38, 0.44, 0.5, 0.56, 0.69, 0.99999, 0.1, 0.13, 0.16, 0.2, 0.24, 0.29, 0.35, 0.41, 0.47, 0.53, 0.59, 0.73, 1, 0.15, 0.19, 0.23, 0.28, 0.33, 0.39, 0.45, 0.51, 0.57, 0.64, 0.78, 0.99999, 0.256, 0.6, 0.99999, 0.6, 0.99999]);


"""
    SysPenality(x)

returns gaussian penality for introducing systematics
"""

function SysPenality(x)
    val = (1/sqrt(2*pi))*exp(-(x*x/2.))
    return val
end

"""
    Init_sys()

Reads various systematic errors and feeds them for further use
"""
function Init_sys()
# NP1 429
# NP2 153
# nsyst 8

 TM_Elements_ePp  = zeros(NP1,NP2)
 TM_Elements_eMp  = zeros(NP1,NP2)
    
 TM_Elements_ePp = get_TM_elements(0,MD_ZEUS_I1787035);
 TM_Elements_eMp = get_TM_elements(1,MD_ZEUS_I1787035);


 Tnm_Ee_sys_ePp = zeros(NP1,NP2)
 Tnm_Eehigh_ePp[NP1,NP2]
    
 Tnm_sys_ePp = zeros(NP1,NP2,nsyst)
 Tnm_sys_eMp = zeros(NP1,NP2,nsyst)

 TM_Elements_ePp = TM_Elements_ePp / MD_ZEUS_I1787035.Ld_ePp
 TM_Elements_eMp = TM_Elements_eMp / MD_ZEUS_I1787035.Ld_eMp
    

 for i in 1:NP1
    for j in 1:NP2
     Tnm_Ee_sys_ePp[i,j] =( abs(Tnm_Eehigh_ePp[i,j] - TM_Elements_ePp[i,j]) +abs(Tnm_Eelow_ePp[i,j] - TM_Elements_ePp[i,j]) )/2.0

     Tnm_sys_ePp[i,j,1] =( abs(Tnm_Eehigh_ePp[i,j] - TM_Elements_ePp[i,j]) +abs(Tnm_Eelow_ePp[i,j] - TM_Elements_ePp[i,j]) )/2.0

     Tnm_sys_ePp[i,j,2] =( abs(Tnm_Eeconehigh_ePp[i,j] - TM_Elements_ePp[i,j]) +abs(Tnm_Eeconelow_ePp[i,j] - TM_Elements_ePp[i,j]) )/2.

     Tnm_sys_ePp[i,j,3] =(abs(Tnm_Eereshigh_ePp[i,j] - TM_Elements_ePp[i,j]) +abs(Tnm_Eereslow_ePp[i,j] - TM_Elements_ePp[i,j]) )/2.

     Tnm_sys_ePp[i,j,4] =( abs(Tnm_Ejhigh_ePp[i,j] - TM_Elements_ePp[i,j]) +abs(Tnm_Ejlow_ePp[i,j] - TM_Elements_ePp[i,j]))/2.

     Tnm_sys_ePp[i,j,5] =(abs(Tnm_FBcalhigh_ePp[i,j] - TM_Elements_ePp[i,j]) +abs(Tnm_FBcallow_ePp[i,j] - TM_Elements_ePp[i,j]))/2.

     Tnm_sys_ePp[i,j,6] =(abs(Tnm_FCALxhigh_ePp[i,j] - TM_Elements_ePp[i,j]) +abs(Tnm_FCALxlow_ePp[i,j] - TM_Elements_ePp[i,j]) )/2.

     Tnm_sys_ePp[i,j,7] =(abs(Tnm_FCALyhigh_ePp[i,j] - TM_Elements_ePp[i,j]) +abs(Tnm_FCALylow_ePp[i,j] - TM_Elements_ePp[i,j]) )/2.

     Tnm_sys_ePp[i,j,8] =(abs(Tnm_AriMepsUp_ePp[i,j] - TM_Elements_ePp[i,j]) +abs(Tnm_AriMepsDown_ePp[i,j] - TM_Elements_ePp[i,j]) )/2.

     Tnm_sys_eMp[i,j,1] =(abs(Tnm_Eehigh_eMp[i,j] - TM_Elements_eMp[i,j]) +abs(Tnm_Eelow_eMp[i,j] - TM_Elements_eMp[i,j]))/2.

     Tnm_sys_eMp[i,j,2] =(abs(Tnm_Eeconehigh_eMp[i,j] - TM_Elements_eMp[i,j]) +abs(Tnm_Eeconelow_eMp[i,j] - TM_Elements_eMp[i,j]))/2.

     Tnm_sys_eMp[i,j,3] =(abs(Tnm_Eereshigh_eMp[i,j] - TM_Elements_eMp[i,j]) +abs(Tnm_Eereslow_eMp[i,j] - TM_Elements_eMp[i,j]))/2.

     Tnm_sys_eMp[i,j,4] =(abs(Tnm_Ejhigh_eMp[i,j] - TM_Elements_eMp[i,j]) +abs(Tnm_Ejlow_eMp[i,j] - TM_Elements_eMp[i,j]) )/2.

     Tnm_sys_eMp[i,j,5] =(abs(Tnm_FBcalhigh_eMp[i,j] - TM_Elements_eMp[i,j]) +abs(Tnm_FBcallow_eMp[i,j] - TM_Elements_eMp[i,j]) )/2.

     Tnm_sys_eMp[i,j,6] =(abs(Tnm_FCALxhigh_eMp[i,j] - TM_Elements_eMp[i,j]) +abs(Tnm_FCALxlow_eMp[i,j] - TM_Elements_eMp[i,j]) )/2.

     Tnm_sys_eMp[i,j,7] =(abs(Tnm_FCALyhigh_eMp[i,j] - TM_Elements_eMp[i,j]) +abs(Tnm_FCALylow_eMp[i,j] - TM_Elements_eMp[i,j]) )/2.

     Tnm_sys_eMp[i,j,8] =(abs(Tnm_AriMepsDown_eMp[i,j] - TM_Elements_eMp[i,j]) +abs(Tnm_AriMepsUp_eMp[i,j] - TM_Elements_eMp[i,j]) )/2.

    end
 end
    
     println(TM_Elements_ePp[NP1,NP2])
     println(Tnm_Eehigh_ePp[NP1,NP2])
     println(Tnm_Eelow_ePp[NP1,NP2])
     println(Tnm_Ee_sys_ePp[NP1,NP2])
     println(Tnm_sys_ePp[NP1,NP2,1])
    
     Tnm_sys_ePp = Tnm_sys_ePp * MD_ZEUS_I1787035.Ld_ePp
     Tnm_sys_eMp = Tnm_sys_eMp * MD_ZEUS_I1787035.Ld_eMp
    
     println(Tnm_Ee_sys_ePp[NP1,NP2])
     println(Tnm_sys_ePp[NP1,NP2,1])
    
end
