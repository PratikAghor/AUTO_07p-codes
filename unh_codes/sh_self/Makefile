#
#   Makefile		Pratik Aghor
#
PGM    = sh
FC     = f95
FFLAGS = -O
SRC    = $(PGM).f
EXE    = $(PGM).exe
LIBS   = $(AUTO_DIR)/lib/*.o
RM     = rm -f
#
all: clean $(EXE) run
#
$(EXE): $(SRC:.f=.o)
	$(FC) $(FFLAGS) $(SRC:.f=.o) -o $@ $(LIBS)
#
#run: first second third fourth fifth sixth
run: first second third fourth fifth
#
first:	$(EXE)
	@echo " "
	@echo "$(PGM) has started"
	@echo " "
	@echo "$(PGM) : run1"
	@cp c.$(PGM).1 fort.2
	@touch fort.3
	@./$(EXE)
	@echo " Saved as *.ode"
	@cp fort.7 b.ode
	@cp fort.8 s.ode
	@cp fort.9 d.ode
	@$(RM) fort.*
#
second:	$(EXE)
	@echo " "
	@echo "$(PGM) : run11"
	@cp c.$(PGM).11 fort.2
	@./$(EXE)
	@cat fort.7 > b.$(PGM)
	@cat fort.8 > s.$(PGM)
	@cat fort.9 > d.$(PGM)
	@echo " Saved as *.$(PGM)"
	@$(RM) fort.*
#
third:	$(EXE)
	@echo " "	
	@echo "$(PGM) : run12"
	@cp c.$(PGM).12 fort.2
	@cp s.$(PGM)   fort.3
	@./$(EXE)
	@cat fort.7 >> b.$(PGM)
	@cat fort.8 >> s.$(PGM)
	@cat fort.9 >> d.$(PGM)
	@echo " Appended to *.$(PGM)"
	@$(RM) fort.*
#
clean:
	@echo "Cleaning $(PGM) ..."
	@cp $(SRC) $(EXE)
	@$(RM) *.exe *.o b.* s.* d.* fort.* *~ core
	@cp c.$(PGM).1 c.$(PGM)
	@echo "Cleaning ... done"
 
