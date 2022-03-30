class solution:

def __init__(self):


self.all = 


def permutation(self, ss):


# write code here


# ss = list(ss)


next_ss = true


while next_ss:


nextss = list(ss)


for i in range(len(nextss)-1, 0, -1):


if nextss[i-1] < nextss[i]:


# import pdb;pdb.set_trace()


for j in range(len(nextss)-1,i-1, -1):


if nextss[j] > nextss[i-1]:


nextss[i-1], nextss[j] = nextss[j], nextss[i-1]


nextss[i:] = nextss[i:][::-1]


break


break


nextss = ''.join(nextss)


# print(nextss)


# import pdb;pdb.set_trace()


if ss == nextss:


next_ss = false


else:


ss = nextss


# print(self.all)


return self.all